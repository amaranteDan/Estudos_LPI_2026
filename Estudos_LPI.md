# 101.1 Identificar e editar configurações de hardware

Este tópico aborda a interação entre o sistema operacional Linux e o hardware subjacente, focando em firmware (BIOS/UEFI) e ferramentas de inspeção de barramentos.

## 1. Firmware do Sistema: BIOS e UEFI

O firmware é o software de baixo nível que inicia o hardware antes do carregamento do Sistema Operacional.

* **BIOS (Basic Input/Output System):** Padrão legado, utiliza o setor MBR para inicialização.
* **UEFI (Unified Extensible Firmware Interface):** Padrão moderno, suporta discos maiores (GPT), interface gráfica e Secure Boot.

### Acesso ao Firmware
O acesso ocorre durante o POST (Power-On Self-Test). As teclas de interrupção comuns são:
* **Teclas de Função:** `F2`, `F10`, `F12`.
* **Outras:** `DEL` ou `ESC`.

---

## 2. Inspeção de Dispositivos (Barramentos)

No Linux, a inspeção de hardware pode ser feita via comandos de utilitários ou consultando o sistema de arquivos virtual `/proc` e `/sys`.

## 2.1. Fontes de Informação do Sistema
Além dos comandos, o Linux armazena informações de hardware em:

* **/proc/cpuinfo: Detalhes do processador.

/proc/meminfo: Detalhes da memória RAM.

/proc/ioports: Portas de entrada e saída.

### Principais Comandos de Inspeção

| Comando | Descrição |
| :--- | :--- |
| `lspci` | Lista dispositivos conectados ao barramento **PCI** (Ex: placas de vídeo, rede, som). |
| `lsusb` | Lista dispositivos conectados ao barramento **USB**. |
| `lsmod` | Lista os módulos (drivers) do kernel carregados no momento. |

### Exemplo: Barramento PCI (`lspci`)

O comando `lspci` exibe informações detalhadas sobre os controladores internos.
> **Dica:** Use `-v` para modo verboso ou `-nn` para ver os IDs dos fabricantes.

```bash
$ lspci
00:00.0 Host bridge: Intel Corporation Coffee Lake HOST and DRAM Controller (rev 0c)
00:02.0 VGA compatible controller: Intel Corporation UHD Graphics 620 (rev 02)
00:14.0 USB controller: Intel Corporation Cannon Point-LP USB 3.1 xHCI Controller (rev 30)
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL810xE (rev 07)