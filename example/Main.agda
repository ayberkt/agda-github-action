{-# OPTIONS --cubical #-}

module Main where

data Nat : Set where
  zero : Nat
  suc  : Nat -> Nat
