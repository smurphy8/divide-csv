# divide-csv

divide-csv allows you to split up a large csv data file into smaller documents that will print on a set number of pages.
It will put your header line on each page

## Installation

cabal install && cabal build 

## Usage

divide-csv <filename> <pages-per-file> <lines-per-page> <header-line>

## How to run tests

```
cabal configure --enable-tests && cabal build && cabal test
```

## Contributing

TODO: Write contribution instructions here
