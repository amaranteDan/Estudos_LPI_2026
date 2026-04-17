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


## Exercicio de fixação

** Tenho três variaveis $var1, $var2 e $var3. Quero gerar todos os valores possíveis.***

$var1 varia de 1 a 14;
$var2 varai de 1 a 8;
$var3 varia de 1 a 64;

```bash
$ for ((var1=1;var1<=14; var1++))
    {
        echo $var1/$var2/$var3
        for ((var2=1;var2<=8;var2++))
        {
            echo $var1/$var2/$var3
            for ((var3=1;var3<64;var3++))
            {
                echo $var1/$var2/$var3
            }
        }
    }
```

Resposta:
Para gerar todas as combinações possíveis (o que chamamos de Produto Cartesiano), a forma mais limpa e moderna no Bash é usar a Expansão de Chaves (Brace Expansion) ou ajustar a estrutura do seu for.

Aqui estão as duas melhores formas de resolver:
Solução 1: A "Mágica" do Bash (Expansão de Chaves)
Se o seu objetivo é apenas imprimir as combinações na tela, o Bash faz isso em uma única linha, sem precisar de loops complexos.

```bash
$ echo {1..14}/{1..8}/{1..64}

condição semelhante

$ echo -e {1..14}/{1..8}/{1..64}'\n' # Imprime linha por linha por causa do -e

Ou

$ printf "%s\n" {1..14}/{1..8}/{1..64} # vai imprimir linha por linha

Usando o looping:

# Estrutura limpa usando 'do' e 'done'
for var1 in {1..14}; do
    for var2 in {1..8}; do
        for var3 in {1..64}; do
            echo "$var1/$var2/$var3"
        done
    done
done

ou ainda

for Termo in $(echo {1..14}/{1..8}/{1..64})
do
    echo $Termo
done    
```

## Usando o comando time
*** Ele é um utilitário de medição. Quando você o coloca antes de qualquer comando, ele não altera o que o comando faz, mas observa a execução e reporta o consumo de recursos de tempo ao final.***

Entendendo os Resultados (A saída do time)A saída dividida em três partes é fundamental para entender o desempenho no Linux:real (Tempo Real/Relógio): É o tempo total decorrido, como se você tivesse usado um cronômetro na mão. Desde o momento em que apertou Enter até o comando terminar. Inclui o tempo gasto com espera de disco ou outros processos rodando no CPU.user (Tempo de Usuário): É o tempo que o processador gastou executando o código do programa ls em si (dentro do que chamamos de "espaço do usuário").sys (Tempo de Sistema): É o tempo que o processador gastou executando chamadas de sistema em nome do programa (como pedir ao Kernel para ler o conteúdo do diretório no disco).Curiosidade: No seu exemplo, o tempo real e sys foram idênticos ($0,008s$), o que é comum em comandos muito rápidos e simples que dependem quase que totalmente de uma leitura rápida do sistema de arquivos ***

```bash
$ time ls *aluno*
aluno1.txt  aluno2.txt  aluno3.txt

real    0m0,008s
user    0m0,001s
sys     0m0,008s

$ \time ls *aluno* # Escape com a contra barra. Chamou o time intríseco
aluno1.txt  aluno2.txt  aluno3.txt
0.00user 0.00system 0:00.00elapsed 100%CPU (0avgtext+0avgdata 2480maxresident)k
0inputs+0outputs (0major+121minor)pagefaults 0swaps
```


# Guia Rápido: Expansão de Comandos e Redirecionamentos no Shell

## 1. Substituição de Comandos

Permite usar a saída de um comando como argumento de outro.

### Forma legada: crases

Ainda funciona, mas **não é recomendada** — difícil de ler e aninhar.

```bash
$ echo "Hostname: `uname -n`"
Hostname: meupc
```

### Forma moderna (recomendada): `$(...)`

Mais legível e suporta aninhamento limpo.

```bash
$ echo "Hostname: $(uname -n)"
Hostname: meupc

$ echo "Diretório atual: $(basename $(pwd))"
Diretório atual: projetos
```

---

## 2. Redirecionamento de Saída (Output)

### `>` — Sobrescreve o arquivo

```bash
$ ls > arquivos.txt

$ cat arquivos.txt
arquivo1.sh  arquivo2.sh  notas.txt
```

### `>>` — Adiciona ao final do arquivo

```bash
$ echo "novo registro" >> log.txt

$ cat log.txt
registro anterior
novo registro
```

### `2>` — Redireciona apenas erros (stderr)

```bash
$ ls /pasta_inexistente 2> erros.log

$ cat erros.log
ls: não é possível acessar '/pasta_inexistente': Arquivo ou diretório não encontrado
```

### `&>` — Redireciona stdout + stderr (bash)

```bash
$ comando_qualquer &> tudo.log
```

### `2>&1` — Junta stderr com stdout

```bash
$ comando > saida.log 2>&1
```

### Descartando tudo com `/dev/null`

```bash
$ comando > /dev/null 2>&1
```

> Executa silenciosamente — útil em scripts e cron jobs.

---

## 3. Redirecionamento de Entrada (Input)

### `<` — Entrada via arquivo

```bash
$ wc -l < lista.txt
42
```

### `<<` — Here Document (multilinha)

Muito usado em scripts para gerar arquivos ou passar blocos de texto.

```bash
$ cat << EOF > mensagem.txt
> Linha 1
> Linha 2
> EOF

$ cat mensagem.txt
Linha 1
Linha 2
```

### `<<<` — Here String

Passa uma string diretamente como entrada. Substitui `echo "texto" | comando`.

```bash
$ base64 <<< "texto_secreto"
dGV4dG9fc2VjcmV0bwo=

$ wc -c <<< "hello"
6
```

---

## 4. Pipes e Fluxo de Dados

### Pipe (`|`)

Conecta a saída de um comando à entrada de outro.

```bash
$ ps aux | grep nginx
root  1234  0.0  nginx: master process
www   1235  0.0  nginx: worker process

$ cat /etc/passwd | cut -d: -f1 | sort
daemon
root
usuario
```

### Comando `tee`

Duplica a saída: mostra no terminal **e** salva em arquivo ao mesmo tempo.

```bash
$ df -h | tee uso_disco.txt
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   20G   28G  42% /

$ cat uso_disco.txt
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   20G   28G  42% /
```

Append com `-a`:

```bash
$ uptime | tee -a log_sistema.txt
 10:32:01 up 3 days,  2:14,  1 user,  load average: 0.10, 0.08, 0.05
```

---

## 5. Operadores de Controle

### `&&` — AND: executa o próximo só se o anterior tiver sucesso

```bash
$ make && make install
gcc -o programa main.c
install: programa -> /usr/local/bin/programa
```

### `||` — OR: executa o próximo só se o anterior falhar

```bash
$ ping -c1 servidor || echo "Servidor inacessível"
ping: servidor: Name or service not known
Servidor inacessível
```

### `;` — Sequência: executa independente de sucesso ou erro

```bash
$ echo "início" ; ls /inexistente ; echo "fim"
início
ls: não é possível acessar '/inexistente': Arquivo ou diretório não encontrado
fim
```

---

## Boas Práticas

- Prefira `$(...)` em vez de crases
- Use `2>&1` para capturar tudo em logs
- Use `/dev/null` para silenciar saídas em scripts e cron
- Prefira `>>` quando não quiser perder dados anteriores no arquivo
- Combine `grep`, `awk`, `sed` com pipes para automação poderosa

### Observação:
- Quando o interpretador identifica uma saída `(>)` a primeira coisa que ele faz é criar o arquivo vazio, depois manda o comando para execução e a sua saída é colocada no arquivo.
- Isso é 100 vezes mais rapido do que criar arquivo com o `touch`;
- Mas ussa so ele, reescreve o arquivo. Se quiser fazer o `append`, devemos usar `>>`, que faz o append no final do arquivo. Vamos a alguns exercicios.

```bash
$ seq 3 -1 1

daniel@amazonia:~/Documentos/Estudos_LPI_2026$ seq 3 -1 1
3
2
1
seq 3 -1 1 > nums.txt
echo 4 >> nums.txt 
cat nums.txt 
3
2
1
4
# Quando fiz o append fez uma desordem no arquivo. E para arrumar?

$ sort -nr nums.txt -o nums.txt # Sort numérico(n), reverso(r), saída em nums.txt (o)
$ cat nums.txt 
4
3
2
1
```

```bash
$ programa1.sh > log2 log.err # Joga as saídas em log e os erros em log.err

$ programa1.sh 2> /dev/null # Descarta saída de erro para /dev/null -> Buraco negro ;(

$ programa1.sh 2>&- # 2>&- — Fechando o stderr O &- significa fechar o file descriptor

# Na dúvida, sempre use 2>/dev/null. O 2>&- é mais usado em scripts avançados onde você controla os file descriptors manualmente com exec.

# Resumo: o 2>&- silencia erros dentro do processo executado, mas erros do próprio shell (como "comando não encontrado") escapam porque vêm de um nível acima.
```bash
$ programa1.sh 2>&-
programa1.sh: comando não encontrado   # erro do SHELL, não do programa

$ ./programa1.sh 2>&-
bash: ./programa1.sh: Arquivo ou diretório não encontrado  # idem
```

## Redirecionamento da Entrada

```bash
$ wc -w /etc/passwd
93 /etc/passwd
ou
$ wc -w < /etc/passwd
93

$ Var=5
python3 << fim
> print($Var)
> fim
5

# Passo a passo:
- Var=5 → cria uma variável no shell com valor 5
- python3 << fim → abre um Here Document, passando tudo até fim como stdin pro python3
- print($Var) → antes de enviar pro Python, o shell expande $Var, substituindo por 5
- O Python recebe e executa: print(5)
- Resultado: 5
```
## FD File Descriptor

| FD | Finalidade | Representado por |
| :--- | :--- |   :--- |
| `[0]` | stdin | 0< ou < | 
| `[1]` | stdout| 1> ou > |
| `[2]` | stderr| 2>      |
|

## Usando o pipe |
```bash
$ echo Atualmente existem $(who | wc -l) usuarios conectados
```

## Realizando contas com o redirecionamento

```bash
$ bc <<< 2+2
4

$ bc <<< "scale=3; 22/7"
3.142

$ bc <<< "scale=3; 22/7" | tee resultado.txt
3.142

$ cat resultado.txt
3.142

# Bônus: E se eu quiser salvar a conta e o resultado?
- Se você quiser registrar o que foi calculado e o valor gerado no mesmo arquivo, pode fazer assim:

$ echo "scale=3; 22/7" | tee conta.txt | bc | tee -a conta.txt
3.142

$ cat conta.txt
scale=3; 22/7
3.142

```
## Extraindo um arquivo tar

```bash
$ tar -zxf Programacao-Shell-Linux-Exercicios-Arquivos.tar.gz

ou

$ tar -zvxf Programacao-Shell-Linux-Exercicios-Arquivos.tar.gz

# ou extraindo para uma pasta especifica
$ tar -ztf Programacao-Shell-Linux-Exercicios-Arquivos.tar.gz

# O -t (list) mostra o que tem dentro sem descompactar nada.

```
