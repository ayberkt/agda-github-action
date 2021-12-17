{-# OPTIONS --safe #-}

open import Data.Bool

module Main where

data Nat : Set where
  zero : Nat
  suc  : Nat -> Nat
