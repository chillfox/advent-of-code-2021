.RECIPEPREFIX = >

.PHONY: run build format check

day = 1
name = day_$$(printf "%02d" ${day})

run:
>   @crystal run src/${name}.cr

build:
>   @crystal build --release -o bin/${name} src/${name}.cr

format:
>   @crystal tool format

check:
>   @ameba
