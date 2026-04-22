# Iniciando Estudos do Podman:
### Instalando no Linux Mint
```bash
sudo apt-get update
sudo apt-get -y install podman

# Verificando os containeres
$ podman ps -a

## Parar o container
$ podman stop <container_id>

## Remover o container
$ podman rm <container_id>

## Verificando os logs dos containeres
podman logs <container_id>
10.88.0.1 - - [07/Feb/2018:15:22:11 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.55.1" "-"
10.88.0.1 - - [07/Feb/2018:15:22:30 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.55.1" "-"
10.88.0.1 - - [07/Feb/2018:15:22:30 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.55.1" "-"
10.88.0.1 - - [07/Feb/2018:15:22:31 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.55.1" "-"
10.88.0.1 - - [07/Feb/2018:15:22:31 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.55.1" "-"

Aqui está a tradução para português, mantendo a formatação técnica adequada para documentação em Markdown:

---

## O que é o Podman?

O **Podman** é uma ferramenta nativa do Linux, de código aberto e *daemonless* (sem a necessidade de um processo em segundo plano), projetada para facilitar a busca, execução, criação, compartilhamento e implantação de aplicações usando **Containers OCI** (*Open Containers Initiative*) e imagens de container.

O Podman oferece uma interface de linha de comando (CLI) familiar para qualquer pessoa que já tenha utilizado o motor de containers **Docker**. A maioria dos usuários pode simplesmente criar um alias do Docker para o Podman (`alias docker=podman`) sem problemas. Assim como outros motores de containers comuns (Docker, CRI-O, containerd), o Podman depende de um **Runtime de Container** compatível com OCI (*runc, crun, runv*, etc.) para interagir com o sistema operacional e criar os containers em execução. Isso torna os containers criados pelo Podman quase indistinguíveis daqueles criados por qualquer outro motor de container comum.

### Gerenciamento e Segurança
Os containers sob o controle do Podman podem ser executados tanto pelo usuário **root** quanto por um **usuário sem privilégios** (*rootless*). O Podman gerencia todo o ecossistema de containers — que inclui pods, containers, imagens e volumes — utilizando a biblioteca **libpod**. 

O Podman é especializado em todos os comandos e funções que ajudam a manter e modificar imagens de container OCI, como o download (*pull*) e a criação de tags. Ele permite criar, executar e manter esses containers e imagens em um ambiente de produção.

### API e Compatibilidade
Existe uma **API RESTful** para gerenciar os containers. Também dispomos de um cliente remoto do Podman que pode interagir com esse serviço RESTful. Atualmente, oferecemos suporte para clientes em **Linux, Mac e Windows**, embora o serviço RESTful seja suportado apenas no Linux.

---

### Links Úteis
* Se você é totalmente novo no mundo dos containers, recomendamos que consulte a **Introdução**.
* Para usuários experientes ou que estão vindo do Docker, confira nossos **Tutoriais**.
* Para usuários avançados e contribuidores, informações detalhadas sobre a CLI do Podman podem ser encontradas na página de **Comandos**.
* Para desenvolvedores que buscam interagir com a API do Podman, consulte nossa documentação de **Referência da API**.
