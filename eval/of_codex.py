import sys 
import os
from tqdm import tqdm
import json
import yaml
import ndjson
import openai
import pathlib

from ratelimit import limits, sleep_and_retry

def batch_loader(seq, size):
    """
    Iterator that takes in a list `seq` and returns
    chunks of size `size`
    """
    return [seq[pos : pos + size] for pos in range(0, len(seq), size)]

# calls=3, period=60 is max for reliability with batch_size=20
# might want to throttle it to keep lean chat up
@sleep_and_retry
@limits(calls=2, period=60)
def call_api(prompt, stop, max_tokens=150,):
    return openai.Completion.create(
        engine="code-davinci-002",
        prompt=prompt,
        max_tokens=max_tokens,
        n=1,
        temperature=0,
        stop=stop,
    )


def main():
    with open(sys.argv[1]) as f: 
        cfg = yaml.safe_load(f)

    BATCH_SIZE = cfg["batch_size"]
    BEFORE_EXAMPLE = cfg["before_example"]
    AFTER_EXAMPLE = cfg["after_example"]
    IN_KEY = cfg["in_key"]
    OUT_KEY = cfg["out_key"]
    save_dir = cfg["save_dir"]
    save_file = cfg["save_file"]
    pathlib.Path(save_dir).mkdir(parents=True, exist_ok=True) 
    few_shot_prompt_path = cfg["few_shot_prompt_path"]
    data_path = cfg["data_path"]
    STOP = cfg["stop"]
    max_tokens = cfg["max_tokens"]

    with open(few_shot_prompt_path) as f: 
        FEW_SHOT_PROMPT = f.read()

    with open(data_path) as f:
        data = ndjson.load(f)

    if os.path.isfile(os.path.join(save_dir, save_file)): 
        print("WARNING: AUGMENTING EXISTING FILE WITH NEW IDS")
        with open(os.path.join(save_dir, save_file)) as f: 
            old_data = ndjson.load(f)

        old_data_ids = set([x["id"] for x in old_data])
        data = [x for x in data if x["id"] not in old_data_ids]

    dataloader = batch_loader(data, BATCH_SIZE)

    for batch in tqdm(dataloader): 
        prompts = [FEW_SHOT_PROMPT + BEFORE_EXAMPLE + x[IN_KEY] + AFTER_EXAMPLE for x in batch]

        outs = call_api(prompts, stop=STOP, max_tokens=max_tokens)

        finish_reasons = [x["finish_reason"] 
                for x in outs["choices"]]
        if "length" in finish_reasons: 
            print("HIT LENGTH LIMIT, RETRYING WITH MORE TOKENS")
            outs = call_api(prompts, stop=STOP, max_tokens=400)

        text_outs = [x["text"] for x in outs["choices"]]

        for text_out, step in zip(text_outs, batch):
            step[OUT_KEY] = text_out

            with open(os.path.join(save_dir, save_file), "a+") as f: 
                record = json.dumps(step)
                f.write(record+"\n")

if __name__=="__main__": 
    main()
