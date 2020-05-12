{-# OPTIONS --cubical #-}

module Main where

open import Cubical.Core.Everything

-- The "hello world" of Agda seems to be the circle as an HIT so here you go.
data S¹ : Type₀ where
  base : S¹
  loop : base ≡ base
