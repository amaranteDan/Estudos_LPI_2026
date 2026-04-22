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

# Listando com detalhes o modulo Ethernet
lspci -s 02:00 -v
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL810xE PCI Express Fast Ethernet controller (rev 07)
        Subsystem: Dell RTL810xE PCI Express Fast Ethernet controller
        Flags: bus master, fast devsel, latency 0, IRQ 16
        I/O ports at 3000 [size=256]
        Memory at c2204000 (64-bit, non-prefetchable) [size=4K]
        Memory at c2200000 (64-bit, prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: r8169
        Kernel modules: r8169


# Método super verboso
lspci -s 02:00 -vvv
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL810xE PCI Express Fast Ethernet controller (rev 07)
        Subsystem: Dell RTL810xE PCI Express Fast Ethernet controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 3000 [size=256]
        Region 2: Memory at c2204000 (64-bit, non-prefetchable) [size=4K]
        Region 4: Memory at c2200000 (64-bit, prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: r8169
        Kernel modules: r8169


# verifica qual módulo do kernel em uso
lspci -s 02:00 -k
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL810xE PCI Express Fast Ethernet controller (rev 07)
        Subsystem: Dell RTL810xE PCI Express Fast Ethernet controller
        Kernel driver in use: r8169
        Kernel modules: r8169

# listando dispositivos usb

lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 004: ID 0c45:671e Microdia Integrated_Webcam_HD
Bus 001 Device 017: ID 046d:c534 Logitech, Inc. Unifying Receiver
Bus 001 Device 005: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560 Jefferson Peak (JfP)
Bus 001 Device 014: ID 3151:3020 YICHIP Wireless Device
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

# Modo detalhado com com parametros -v -d
 lsusb -v -d 3151:3020

Bus 001 Device 014: ID 3151:3020 YICHIP Wireless Device
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x3151 
  idProduct          0x3020 
  bcdDevice            0.02
  iManufacturer           1 YICHIP
  iProduct                2 Wireless Device
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x003b
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               2.00
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      63
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               2
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               2.00
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     163
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               2

# Modo tree/arvore

$ lsusb -t 
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/6p, 10000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/12p, 480M
    |__ Port 1: Dev 14, If 1, Class=Human Interface Device, Driver=usbhid, 12M
    |__ Port 1: Dev 14, If 0, Class=Human Interface Device, Driver=usbhid, 12M
    |__ Port 2: Dev 17, If 0, Class=Human Interface Device, Driver=usbhid, 12M
    |__ Port 2: Dev 17, If 1, Class=Human Interface Device, Driver=usbhid, 12M
    |__ Port 6: Dev 4, If 0, Class=Video, Driver=uvcvideo, 480M
    |__ Port 6: Dev 4, If 1, Class=Video, Driver=uvcvideo, 480M
    |__ Port 10: Dev 5, If 0, Class=Wireless, Driver=btusb, 12M
    |__ Port 10: Dev 5, If 1, Class=Wireless, Driver=btusb, 12M

# Verificando os modulos kernel carregados no sistema linux fornecidos pelo pacote kmod

$ lsmod

Module                  Size  Used by
ufs                   106496  0
qnx4                   16384  0
hfsplus               118784  0
hfs                    69632  0
minix                  49152  0
ntfs                  122880  0
msdos                  20480  0
jfs                   233472  0
xfs                  1769472  0
cpuid                  16384  0
udf                   126976  0
crc_itu_t              16384  1 udf
isofs                  53248  0
usb_storage            77824  0
snd_usb_audio         372736  0
snd_usbmidi_lib        45056  1 snd_usb_audio
usblp                  28672  0
xt_conntrack           16384  2
xt_MASQUERADE          20480  2
bridge                311296  0
stp                    16384  1 bridge
llc                    16384  2 bridge,stp
xfrm_user              40960  1
xfrm_algo              16384  1 xfrm_user
xt_set                 20480  0
ip_set                 53248  1 xt_set
nft_counter            16384  24
nft_chain_nat          16384  5
nf_nat                 49152  2 nft_chain_nat,xt_MASQUERADE
nf_conntrack          172032  3 xt_conntrack,nf_nat,xt_MASQUERADE
nf_defrag_ipv6         24576  1 nf_conntrack
nf_defrag_ipv4         16384  1 nf_conntrack
xt_addrtype            16384  4
nft_compat             20480  8
nf_tables             266240  57 nft_compat,nft_counter,nft_chain_nat
nfnetlink              20480  4 nft_compat,nf_tables,ip_set
vboxnetadp             28672  0
vboxnetflt             28672  0
vboxdrv               573440  2 vboxnetadp,vboxnetflt
ccm                    20480  6
rfcomm                 81920  16
cmac                   16384  3
algif_hash             16384  1
algif_skcipher         16384  1
af_alg                 32768  6 algif_hash,algif_skcipher
bnep                   28672  2
overlay               151552  0
binfmt_misc            24576  1
zfs                  4112384  0
zunicode              348160  1 zfs
zzstd                 491520  1 zfs
zlua                  163840  1 zfs
zavl                   16384  1 zfs
icp                   311296  1 zfs
zcommon               106496  2 zfs,icp
znvpair                98304  2 zfs,zcommon
spl                   118784  6 zfs,icp,zzstd,znvpair,zcommon,zavl
dell_laptop            32768  0
snd_ctl_led            24576  0
snd_sof_pci_intel_cnl    16384  0
snd_sof_intel_hda_common   102400  1 snd_sof_pci_intel_cnl
soundwire_intel        45056  1 snd_sof_intel_hda_common
soundwire_generic_allocation    16384  1 soundwire_intel
soundwire_cadence      36864  1 soundwire_intel
snd_sof_intel_hda      20480  1 snd_sof_intel_hda_common
mei_hdcp               24576  0
snd_hda_codec_hdmi     77824  1
snd_sof_pci            20480  2 snd_sof_intel_hda_common,snd_sof_pci_intel_cnl
snd_sof_xtensa_dsp     16384  1 snd_sof_intel_hda_common
intel_rapl_msr         20480  0
snd_sof               147456  2 snd_sof_pci,snd_sof_intel_hda_common
snd_soc_hdac_hda       24576  1 snd_sof_intel_hda_common
snd_hda_ext_core       32768  3 snd_sof_intel_hda_common,snd_soc_hdac_hda,snd_sof_intel_hda
snd_soc_acpi_intel_match    61440  2 snd_sof_intel_hda_common,snd_sof_pci_intel_cnl
snd_soc_acpi           16384  2 snd_soc_acpi_intel_match,snd_sof_intel_hda_common
soundwire_bus          94208  3 soundwire_intel,soundwire_generic_allocation,soundwire_cadence
snd_hda_codec_realtek   163840  1
intel_tcc_cooling      16384  0
snd_hda_codec_generic   102400  1 snd_hda_codec_realtek
snd_soc_core          348160  4 soundwire_intel,snd_sof,snd_sof_intel_hda_common,snd_soc_hdac_hda
snd_compress           24576  1 snd_soc_core
x86_pkg_temp_thermal    20480  0
ac97_bus               16384  1 snd_soc_core
snd_pcm_dmaengine      16384  1 snd_soc_core
intel_powerclamp       24576  0
dell_smm_hwmon         24576  0
coretemp               24576  0
snd_hda_intel          53248  3
kvm_intel             372736  0
snd_intel_dspcfg       28672  2 snd_hda_intel,snd_sof_intel_hda_common
nls_iso8859_1          16384  1
snd_intel_sdw_acpi     20480  2 snd_sof_intel_hda_common,snd_intel_dspcfg
snd_hda_codec         163840  5 snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec_realtek,snd_soc_hdac_hda
kvm                  1040384  1 kvm_intel
dell_wmi               24576  1 dell_laptop
snd_hda_core          110592  9 snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_ext_core,snd_hda_codec,snd_hda_codec_realtek,snd_sof_intel_hda_common,snd_soc_hdac_hda,snd_sof_intel_hda
ledtrig_audio          16384  5 snd_ctl_led,snd_hda_codec_generic,dell_wmi,snd_sof,dell_laptop
snd_hwdep              16384  2 snd_usb_audio,snd_hda_codec
snd_pcm               147456  11 snd_hda_codec_hdmi,snd_hda_intel,snd_usb_audio,snd_hda_codec,soundwire_intel,snd_sof,snd_sof_intel_hda_common,snd_compress,snd_soc_core,snd_hda_core,snd_pcm_dmaengine
rapl                   20480  0
intel_cstate           20480  0
snd_seq_midi           20480  0
snd_seq_midi_event     16384  1 snd_seq_midi
dell_smbios            28672  2 dell_wmi,dell_laptop
snd_rawmidi            49152  2 snd_seq_midi,snd_usbmidi_lib
btusb                  61440  0
btrtl                  24576  1 btusb
dcdbas                 20480  1 dell_smbios
snd_seq                77824  2 snd_seq_midi,snd_seq_midi_event
btbcm                  24576  1 btusb
ee1004                 20480  0
btintel                40960  1 btusb
snd_seq_device         16384  3 snd_seq,snd_seq_midi,snd_rawmidi
dell_wmi_descriptor    20480  2 dell_wmi,dell_smbios
wmi_bmof               16384  0
iwlmvm                569344  0
serio_raw              20480  0
snd_timer              40960  2 snd_seq,snd_pcm
snd                   106496  22 snd_ctl_led,snd_hda_codec_generic,snd_seq,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_usb_audio,snd_usbmidi_lib,snd_hda_codec,snd_hda_codec_realtek,snd_timer,snd_compress,snd_soc_core,snd_pcm,snd_rawmidi
soundcore              16384  2 snd_ctl_led,snd
mac80211             1257472  1 iwlmvm
uvcvideo              118784  0
videobuf2_vmalloc      20480  1 uvcvideo
videobuf2_memops       20480  1 videobuf2_vmalloc
videobuf2_v4l2         32768  1 uvcvideo
bluetooth             675840  43 btrtl,btintel,btbcm,bnep,btusb,rfcomm
videobuf2_common       73728  4 videobuf2_vmalloc,videobuf2_v4l2,uvcvideo,videobuf2_memops
libarc4                16384  1 mac80211
joydev                 32768  0
input_leds             16384  0
videodev              258048  3 videobuf2_v4l2,uvcvideo,videobuf2_common
ecdh_generic           16384  2 bluetooth
ecc                    36864  1 ecdh_generic
mc                     65536  5 videodev,snd_usb_audio,videobuf2_v4l2,uvcvideo,videobuf2_common
iwlwifi               454656  1 iwlmvm
processor_thermal_device_pci_legacy    16384  0
processor_thermal_device    20480  1 processor_thermal_device_pci_legacy
processor_thermal_rfim    24576  1 processor_thermal_device
mei_me                 40960  1
processor_thermal_mbox    16384  2 processor_thermal_rfim,processor_thermal_device
cfg80211              974848  3 iwlmvm,iwlwifi,mac80211
processor_thermal_rapl    20480  1 processor_thermal_device
intel_rapl_common      40960  2 intel_rapl_msr,processor_thermal_rapl
hid_multitouch         32768  0
mei                   135168  3 mei_hdcp,mei_me
intel_pch_thermal      20480  0
intel_soc_dts_iosf     20480  1 processor_thermal_device_pci_legacy
int3403_thermal        20480  0
int3402_thermal        16384  0
intel_hid              24576  0
acpi_pad              184320  0
int340x_thermal_zone    20480  3 int3403_thermal,int3402_thermal,processor_thermal_device
sparse_keymap          16384  2 intel_hid,dell_wmi
int3400_thermal        20480  0
mac_hid                16384  0
acpi_thermal_rel       16384  1 int3400_thermal
nfsd                  647168  5
sch_fq_codel           20480  2
msr                    16384  0
auth_rpcgss           139264  1 nfsd
parport_pc             49152  0
nfs_acl                16384  1 nfsd
lockd                 110592  1 nfsd
ppdev                  24576  0
grace                  16384  2 nfsd,lockd
lp                     28672  0
parport                69632  3 parport_pc,lp,ppdev
efi_pstore             16384  0
sunrpc                585728  17 nfsd,auth_rpcgss,lockd,nfs_acl
ip_tables              32768  0
x_tables               53248  6 xt_conntrack,nft_compat,xt_addrtype,xt_set,ip_tables,xt_MASQUERADE
autofs4                49152  2
btrfs                1564672  0
blake2b_generic        20480  0
zstd_compress         229376  1 btrfs
raid10                 69632  0
raid456               163840  0
async_raid6_recov      24576  1 raid456
async_memcpy           20480  2 raid456,async_raid6_recov
async_pq               24576  2 raid456,async_raid6_recov
async_xor              20480  3 async_pq,raid456,async_raid6_recov
async_tx               20480  5 async_pq,async_memcpy,async_xor,raid456,async_raid6_recov
xor                    24576  2 async_xor,btrfs
raid6_pq              122880  4 async_pq,btrfs,raid456,async_raid6_recov
libcrc32c              16384  6 nf_conntrack,nf_nat,btrfs,nf_tables,xfs,raid456
raid1                  49152  0
raid0                  24576  0
multipath              20480  0
linear                 20480  0
dm_mirror              24576  0
dm_region_hash         24576  1 dm_mirror
dm_log                 20480  2 dm_region_hash,dm_mirror
hid_logitech_hidpp     49152  0
hid_logitech_dj        32768  0
amdgpu               9904128  0
iommu_v2               24576  1 amdgpu
gpu_sched              45056  1 amdgpu
usbhid                 65536  2 hid_logitech_dj,hid_logitech_hidpp
i915                 3117056  33
radeon               1839104  3
i2c_algo_bit           16384  3 amdgpu,radeon,i915
drm_ttm_helper         16384  2 amdgpu,radeon
ttm                    86016  4 amdgpu,radeon,drm_ttm_helper,i915
drm_kms_helper        315392  3 amdgpu,radeon,i915
hid_generic            16384  0
syscopyarea            16384  1 drm_kms_helper
sysfillrect            20480  1 drm_kms_helper
sysimgblt              16384  1 drm_kms_helper
crct10dif_pclmul       16384  1
fb_sys_fops            16384  1 drm_kms_helper
crc32_pclmul           16384  0
cec                    65536  2 drm_kms_helper,i915
ghash_clmulni_intel    16384  0
sha256_ssse3           32768  1
sha1_ssse3             32768  0
aesni_intel           376832  8
crypto_simd            16384  1 aesni_intel
cryptd                 24576  3 crypto_simd,ghash_clmulni_intel
rc_core                65536  1 cec
psmouse               184320  0
nvme                   49152  2
r8169                 102400  0
drm                   622592  17 gpu_sched,drm_kms_helper,amdgpu,radeon,drm_ttm_helper,i915,ttm
i2c_i801               36864  0
nvme_core             135168  3 nvme
i2c_smbus              20480  1 i2c_i801
realtek                32768  1
ahci                   49152  0
intel_lpss_pci         24576  0
intel_lpss             16384  1 intel_lpss_pci
libahci                49152  1 ahci
xhci_pci               24576  0
idma64                 20480  0
xhci_pci_renesas       20480  1 xhci_pci
wmi                    32768  4 dell_wmi,wmi_bmof,dell_smbios,dell_wmi_descriptor
i2c_hid_acpi           16384  0
i2c_hid                36864  1 i2c_hid_acpi
hid                   151552  6 i2c_hid,usbhid,hid_multitouch,hid_generic,hid_logitech_dj,hid_logitech_hidpp
video                  65536  3 dell_wmi,dell_laptop,i915
pinctrl_cannonlake     36864  0

# modprobe -r usado para carregar e descarragar modulos desde que não estejam sendo carregados em processo de execução

$ modprobe -r snd-hda-intel
```

# Verificando a memoria swap
```bash
$ free -h 

# Saber onde esta localizado a partição swap

$ swapon --show

ou ler o arquivo

$ cat /proc/swaps

# Verificando a performance

# Ele exibe uma lista detalhada de eventos de memória, incluindo o total de "swap in" e "swap out" (quando o sistema move dados para o disco).
$ vmstat -s 

# Preparando a partição

$ sudo mkswap /dev/sda3

# Ativar o swap
$ sudo swapon /dev/sda3

# Checkar se esta tudo ok
swapon --show

# Tornar a mudança permanente no /etc/fstab

$ sudo nano /etc/fstab

# Checar a tendencia do sistema usar o swap:

$ cat /proc/sys/vm/swappiness

- valor 60(padrão), sistema usa com frequencia
- caso sentir sistema lento, mudar para (10)

# Verifica detalhes

$ ls -lh /swapfile
```
