### Expansão de Chaves (Brace Expansion) no Bash

A expansão de chaves é um mecanismo poderoso para gerar strings de forma dinâmica.

#### Referência de Sintaxe

| Sintaxe | Descrição |
| :--- | :--- |
| `{LISTA}` | Lista de cadeias separadas por vírgulas. |
| `{INI..FIM}` | Início e fim (números, letras ou caracteres especiais). |
| `{INI..FIM..INCR}` | **INCR**: Incremento ou passo (disponível a partir do Bash 4.0). |
| `PREFIXO{****}` | Adiciona um prefixo comum à LISTA ou ao intervalo INI..FIM. |
| `{****}SUFIXO` | Adiciona um sufixo comum à LISTA ou ao intervalo INI..FIM. |
| `PREFIXO{****}SUFIXO` | Combina prefixo e sufixo em cada item gerado. |

#### Exemplos Práticos

```bash
$ echo {r,p,g}ato
# Resultado: rato pato gato

$ echo {A..Z}
# Resultado: A B C ... Z

$ echo {0..10..2}
# Resultado: 0 2 4 6 8 10

$ echo imagem_{1..3}.png
# Resultado: imagem_1.png imagem_2.png imagem_3.png

touch {a,b,c}arq
# a.arq, b.arq, c.arq

$ ls -l *arq

# -rw-rw-r-- 1 daniel daniel 0 mar 29 19:02 a.arq
# -rw-rw-r-- 1 daniel daniel 0 mar 29 19:02 b.arq
#-rw-rw-r-- 1 daniel daniel 0 mar 29 19:02 c.arq
```
#### Criando multiplos arquivos

```bash
$ touch {a..c}.arq

$ touch aluno{1..3}.txt
```

#### Removendo multiplos arquivos vazios

```bash
$ rm {a..c}.arq
```

## Coringas padrão

| Metacaracter | Expande para |
| :--- | :--- |
| `{*}` | Zero ou mais ocorrencias de quaisquer caracteres |
| `{?}` | Um único caracter|
| `[...]` | Qualquer caracter da lista |
| `{****}` | Qualquer caracter que não esteja na lista ou !=(defierente da lista)|
