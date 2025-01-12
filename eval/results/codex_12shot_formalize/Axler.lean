import linear_algebra.finite_dimensional
import linear_algebra.eigenspace
import data.complex.basic
import analysis.inner_product_space.basic
import analysis.inner_product_space.projection
import analysis.inner_product_space.adjoint

open set fintype complex polynomial submodule linear_map
open finite_dimensional module module.End inner_product_space

open_locale big_operators


theorem exercise_1_2 :
  (complex.I * √3 / 2) ^ 3 = 1 :=
sorry

theorem exercise_1_3 {V : Type*} [add_comm_group V] [vector_space ℝ V] 
  (v : V) : -(-v) = v :=
sorry

theorem exercise_1_4 {K V : Type*} [field K] [add_comm_group V] 
  [vector_space K V] (a : K) (v : V) :
  a • v = 0 ↔ a = 0 ∨ v = 0 :=
sorry

theorem exercise_1_6 {U : Type*} [add_comm_group U]
  [vector_space ℝ U] (hU : ∀ (u : U), -u ∈ U) (hU_nonempty : ∃ (u : U), u ≠ 0) :
  ¬ is_subspace U :=
sorry

theorem exercise_1_7 {U : Type*} [add_comm_group U]
  [vector_space ℝ U] (hU : ∀ (x : ℝ) (u : U), u ∈ U → x • u ∈ U)
  (hU_ne : U ≠ (0 : U)) : ¬ is_subspace U :=
sorry

theorem exercise_1_8 {R : Type*} [comm_ring R] {V : Type*} [add_comm_group V] 
  [module R V] {S : set (submodule R V)} :
  is_submodule R (⋂₀ S) :=
sorry

theorem exercise_1_9 {K V : Type*} [field K] [add_comm_group V] 
  [vector_space K V] {U₁ U₂ : subspace V} :
  U₁ ⊔ U₂ = ⊤ ↔ U₁ ⊆ U₂ ∨ U₂ ⊆ U₁ :=
sorry

theorem exercise_3_1 {V : Type*} [field K] [add_comm_group V] 
  [vector_space K V] [finite_dimensional K V] (h : finite_dimensional.dim K V = 1) 
  (T : V →ₗ[K] V) :
  ∃ (a : K), ∀ (v : V), T v = a • v :=
sorry

theorem exercise_3_8 {V W : Type*} 
  [add_comm_group V] [add_comm_group W] [vector_space ℝ V] [vector_space ℝ W] 
  [finite_dimensional ℝ V] {T : V →ₗ[ℝ] W} :
  ∃ (U : submodule ℝ V), U.comap T.to_fun = ⊥ ∧ range T = U.map T.to_fun :=
sorry

theorem exercise_4_4 
  {α : Type*} [discrete_field α] {p : polynomial α} (hp : p.degree > 0) :
  p.has_n_distinct_roots p.degree ↔ p.roots.disjoint p.derivative.roots :=
sorry

theorem exercise_5_1 {V : Type*} [add_comm_group V] 
  [module ℂ V] {T : V →ₗ[ℂ] V} {U : Type*} [fintype U] {f : U → submodule ℂ V} 
  (hf : ∀ (i : U), T.range ⊆ f i) :
  T.range ⊆ ⨆ (i : U), f i :=
sorry

theorem exercise_5_11 {V : Type*} [finite_dimensional V]
  [add_comm_group V] [vector_space ℂ V] {S T : V →ₗ[ℂ] V} :
  eigenvalues (S.comp T) = eigenvalues (T.comp S) :=
sorry

theorem exercise_5_12 {V : Type*} [add_comm_group V]
  [module ℂ V] [finite_dimensional ℂ V] (T : V →ₗ[ℂ] V)
  (hT : ∀ v : V, is_eigenvector ℂ T v) :
  ∃ (c : ℂ), T = c • linear_map.id :=
sorry

theorem exercise_5_13 {K V : Type*} 
  [field K] [add_comm_group V] [vector_space K V] [finite_dimensional K V] 
  (T : V →ₗ[K] V) (hT : ∀ (U : submodule K V), U.dim = V.dim - 1 → T.range ⊆ U) :
  ∃ (c : K), T = c • linear_map.id :=
sorry

theorem exercise_5_20 {K : Type*} [field K] 
  [add_comm_group V] [module K V] [finite_dimensional K V] 
  (T : V →ₗ[K] V) (S : V →ₗ[K] V) (hT : T.dim_eigenvalues = V.dim K) 
  (hS : ∀ (v : V), v ≠ 0 → ∃ (a : K), T v = a • v) :
  S.comm T :=
sorry

theorem exercise_5_24 {V : Type*} [add_comm_group V] 
  [vector_space ℝ V] [finite_dimensional ℝ V] {T : V →ₗ[ℝ] V} 
  (hT : T.no_eigenvalues) (W : submodule ℝ V) (hW : T.preserves W) :
  ∃ (n : ℕ), W.dim = 2 * n :=
sorry

theorem exercise_5_4 {V : Type*} [add_comm_group V] 
  [vector_space ℂ V] {S T : V →ₗ[ℂ] V} (hST : S.comm T) 
  (hTS : T.comm S) (λ : ℂ) :
  S.range_subset (null_space (T - λ • linear_map.id V)) :=
sorry

theorem exercise_6_13  {K : Type*} [field K] [normed_field K] {V : Type*} [add_comm_group V]
  [vector_space K V] [normed_group V] [normed_space K V]
  {n : ℕ} (e : fin n → V) (h : is_orthonormal_basis K e)
  (v : V) :
  ∥v∥^2 = ∑ i in finset.range n, ∥(v • e i)∥^2 ↔ v ∈ span K (e '' finset.range n) :=
sorry

theorem exercise_6_16 {K : Type*} [field K] 
  {V : Type*} [add_comm_group V] [vector_space K V] {U : subspace V} :
  U.orthogonal = {0} ↔ U = ⊤ :=
sorry

theorem exercise_6_2 {V : Type*} 
  [inner_product_space ℝ V] {u v : V} :
  inner_product u v = 0 ↔ ∀ (a : ℝ), ∥u∥ ≤ ∥u + a • v∥ :=
sorry

theorem exercise_6_3 (n : ℕ) (a b : fin n → ℝ) :
  (∑ i in finset.range n, a i * b i) ^ 2 ≤
    (∑ i in finset.range n, i * a i ^ 2) * (∑ i in finset.range n, b i ^ 2 / i) :=
sorry

theorem exercise_6_7 {V : Type*} 
  [inner_product_space ℂ V] (u v : V) :
  inner_product u v = (∥u + v∥^2 - ∥u - v∥^2 + ∥u + I • v∥^2 - ∥u - I • v∥^2) / 4 :=
sorry

theorem exercise_7_10  {V : Type*} [inner_product_space ℂ V] [normed_group V] [normed_space ℂ V]
  {T : V →ₗ[ℂ] V} (hT : normal_operator T) (hT₁ : T ^ 9 = T ^ 8)
  (hT₂ : T ^ 8 = T ^ 7) (hT₃ : T ^ 7 = T ^ 6) (hT₄ : T ^ 6 = T ^ 5)
  (hT₅ : T ^ 5 = T ^ 4) (hT₆ : T ^ 4 = T ^ 3) (hT₇ : T ^ 3 = T ^ 2)
  (hT₈ : T ^ 2 = T) : self_adjoint T :=
sorry

theorem exercise_7_11 {V : Type*} [inner_product_space ℂ V]
  {T : V →L[ℂ] V} (hT : T.is_normal) :
  ∃ (S : V →L[ℂ] V), S.is_normal ∧ S ^ 2 = T :=
sorry

theorem exercise_7_14 
  {V : Type*} [normed_group V] [normed_space ℂ V] [inner_product_space ℂ V] 
  {T : V →ₗ[ℂ] V} (hT : T.is_self_adjoint) (λ : ℂ) (ε : ℝ) 
  (hε : ε > 0) (v : V) (hv : ∥v∥ = 1) (hvT : ∥T v - λ • v∥ < ε) :
  ∃ (λ' : ℂ), T.is_eigenvalue λ' ∧ abs (λ - λ') < ε :=
sorry

theorem exercise_7_5 {V : Type*} [field K] [add_comm_group V] 
  [vector_space K V] [finite_dimensional K V] (h : 2 ≤ finite_dimensional.finrank K V) :
  ¬ submodule K (normal_ops K V) (linear_map.module K V) :=
sorry

theorem exercise_7_6 {V : Type*} [inner_product_space ℂ V]
  [normed_group V] [normed_space ℂ V] {T : V →ₗ[ℂ] V} (hT : T.is_normal) :
  T.range = T.adjoint.range :=
sorry

theorem exercise_7_9 {V : Type*} [inner_product_space ℂ V]
  [normed_group V] [normed_space ℂ V] {T : V →ₗ[ℂ] V} (hT : T.is_normal)
  (hT_eigenvalues : ∀ (λ : ℂ), is_eigenvalue T λ → λ.is_real) :
  T.is_self_adjoint :=
sorry