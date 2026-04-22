#!/bin/bash
#
# Script para verificar o status de saúde do sistema (Disco, CPU, RAM)
# Autor/Manutenção: Daniel Amarante
# Versão: 1.1

#--------------------------------------------------------------------------
# Instruções de uso:
# $ chmod +x verifica_sistema.sh
# $ ./verifica_sistema.sh
#--------------------------------------------------------------------------

# --- Variáveis de Configuração ---
LIMITE=80
STATUS_OK="Sistema OPERACIONAL"
STATUS_ERROR="Sistema COM PROBLEMAS"

# 1. DISCO: Pega o uso da partição raiz (apenas números)
STATUS_DISK=$(df / --output=pcent | tail -1 | tr -dc '0-9')

# 2. CPU: Pega a carga do último minuto, remove vírgulas/pontos e trata como inteiro
# Exemplo: 0,87 vira 87
STATUS_CPU=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | tr -d ' ' | sed 's/[.,]//g' | sed 's/^0//')

# Procura o número que vem antes de 'day'
STATUS_UP_DAYS=$(uptime | grep -oP '\d+(?= day)')

# Se o comando acima for vazio (menos de 24h de uptime), define como 0
STATUS_UP_DAYS=${STATUS_UP_DAYS:-0}

# Garantir que se o valor for vazio (ex: 0.00), ele vire 0
STATUS_CPU=${STATUS_CPU:-0}

# 3. MEMÓRIA: Cálculo direto no AWK para evitar decimais no Shell
STATUS_MEM=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')

# --- Verificação Lógica ---

if [ "$STATUS_DISK" -lt "$LIMITE" ] && [ "${STATUS_CPU%.*}" -lt "$LIMITE" ] && [ "$STATUS_MEM" -lt "$LIMITE" ]; then
    echo "Detalhes -> Disco: $STATUS_DISK% | CPU: $STATUS_CPU% | RAM: $STATUS_MEM% | DAYS_UP: $STATUS_UP_DAYS"
else
    echo "$STATUS_ERROR"
    # Opcional: imprimir onde está o problema para ajudar no debug
    echo "Detalhes -> Disco: $STATUS_DISK% | CPU: $STATUS_CPU% | RAM: $STATUS_MEM% | DAYS_UP: $STATUS_UP_DAYS"
fi