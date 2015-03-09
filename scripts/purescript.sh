#!/usr/bin/env bash

set -e

echo 'Installing PureScript via Haskell Cabal...'

as_vagrant='sudo -u vagrant -H bash -l -c'

$as_vagrant 'cabal install cabal cabal-install'
$as_vagrant 'cabal install purescript'
