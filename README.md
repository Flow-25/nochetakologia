# Nochetakologia
To jest repo poświęcone książce analizującej tajemnicze zjawisko nochetakologii występującej we wszechświecie. Jest to praca naukowa usiłująca odgadnąć przeznaczenie i reguły rządzące tymże zjawiskiem. Książka ta jest zwieńczeniem wieloletnich badań Simona Clausa.

## Kompilacja
Należy sklonować repozytorium:
```bash
git clone [repo_address]
cd nochetakologia
```
Jeśli chcemy zbudować cały projekt wykonujemy komendę `make`. Domyślnie zbuduje się całość książki w katalogu `build`. Budowanie poszczególnych rozdziałów można wykonać komendą 
```bash
make chapter file=nazwa_rozdziału
``` 
której poszczególne pliki zostaną zapisane w katalogu `build/single`.
Komenda `make clean` usuwa katalog `build`.

## Wymagania
Kompilacja wymaga pełnej instalacji TeX Live (lub MiKTeX) oraz narzędzi: XeLaTeX, latexmk, i Biber.
