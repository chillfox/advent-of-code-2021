.RECIPEPREFIX = >

.PHONY: run build format check clean

day = 1
name = day_$$(printf "%02d" ${day})

run:
>   @crystal run src/${name}.cr

build:
>   @mkdir --parents bin
>   @crystal build --release -o bin/${name} src/${name}.cr

format:
>   @crystal tool format

check:
>   @ameba

clean:
>   @rm --dir --recursive bin
