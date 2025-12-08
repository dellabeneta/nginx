# Projeto Nginx - Versão 1

Este projeto utiliza Terraform para provisionar uma infraestrutura de servidor web segura na AWS. O foco principal desta primeira versão (v1) é demonstrar uma arquitetura onde o acesso administrativo é realizado exclusivamente através do AWS Systems Manager (SSM), eliminando a necessidade de expor a porta SSH (22) para a internet.

## Arquitetura

O projeto provisiona os seguintes recursos:

*   VPC e Subnet Pública para hospedagem dos serviços.
*   Security Group configurado para permitir apenas tráfego Web (HTTP porta 80).
*   Instância EC2 baseada em Amazon Linux 2.
*   Roles e Profiles do IAM configurados automaticamente para autorizar o agente SSM na instância.

## Acesso e Gerenciamento (SSM)

A segurança é priorizada ao não utilizar chaves SSH tradicionais. O acesso ao terminal do servidor é feito através do Session Manager, que oferece um canal seguro e auditado.

### Método 1: Acesso via Console AWS (Navegador)

1.  Acesse o Console da AWS e vá para o serviço EC2.
2.  Localize e selecione a instância nomeada como web-server.
3.  Clique no botão Conectar no topo da tela.
4.  Selecione a aba Session Manager e clique em Conectar.
5.  Um terminal será aberto diretamente no seu navegador.

### Método 2: Acesso via Terminal Local

Para conectar via linha de comando, é necessário ter o AWS CLI e o plugin do Session Manager instalados em sua máquina.

Execute o seguinte comando substituindo o ID da instância:

aws ssm start-session --target <ID-DA-INSTANCIA>

Este comando estabelecerá um tunelamento seguro para o shell da instância sem necessidade de portas abertas.

## Instruções de Uso

1.  Inicialize o projeto Terraform:
    terraform init

2.  Verifique o plano de criação:
    terraform plan

3.  Provisione a infraestrutura:
    terraform apply

4.  Após o uso, para remover os recursos:
    terraform destroy
