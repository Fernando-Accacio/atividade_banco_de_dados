# Comanda Digital - Modelo de Dados

Este repositório contém o script SQL para criação do banco de dados do sistema de comanda digital **Los Gourmet**. O script foi elaborado com base no Modelo de Dados Relacional (MFD) apresentado.

## Modelo de Dados Relacional (MFD)

O MFD representa a estrutura lógica do banco de dados e descreve as tabelas, colunas e suas relações. O diagrama apresentado fornece uma visão geral das entidades do sistema e como elas se relacionam.

### Entidades

- **categoria**: Armazena as categorias de produtos (ex: Bebidas, Comidas, Sobremesas).
- **usuarios**: Armazena informações sobre os usuários do sistema, como nome, email, senha e data de criação.
- **produtos**: Armazena informações sobre os produtos disponíveis, incluindo nome, preço, descrição e categoria.
- **pedidos**: Registra os pedidos realizados pelos usuários, incluindo o usuário que fez o pedido, a data do pedido e o status do pedido.
- **itens_pedido**: Armazena os itens de cada pedido, incluindo o ID do pedido, o ID do produto e a quantidade do produto.
- **comandas**: Controla as comandas abertas no restaurante, incluindo a mesa associada, a data de abertura, a data de fechamento (opcional), o status da comanda e o valor total.
- **itens_comanda**: Registra os itens de cada comanda, incluindo o ID da comanda, o ID do produto, a quantidade, o preço unitário, o subtotal e uma observação adicional.

### Relações

- **1:N (Um para Muitos)**:
  - Uma categoria pode conter vários produtos.
  - Um usuário pode fazer vários pedidos.
  - Um pedido pode conter vários itens.
  - Uma comanda pode conter vários itens.

- **N:N (Muitos para Muitos)**:
  - Um produto pode estar presente em vários pedidos e comandas.

---

## Execução do Script SQL

### Pré-requisitos

- **MySQL**: O script foi escrito para o sistema de gerenciamento de banco de dados MySQL.
- **Acesso ao MySQL**: Certifique-se de ter acesso ao MySQL com permissões adequadas para criar bancos de dados e tabelas.

### Passos para execução

1. **Acesse o MySQL**:
   Abra o terminal ou prompt de comando e conecte-se ao MySQL usando o seguinte comando:
   ```bash
   mysql -u seu_usuario -p
   ```
   Substitua `seu_usuario` pelo seu nome de usuário do MySQL. Você será solicitado a inserir sua senha.

2. **Execute o script**:
   - Copie o conteúdo do script SQL fornecido e cole-o no terminal.
   - Ou salve o script em um arquivo com a extensão `.sql` (por exemplo, `comanda_digital.sql`). Para executar o arquivo, use o comando:
     ```bash
     SOURCE caminho/para/comanda_digital.sql;
     ```
     Substitua `caminho/para/` pelo caminho real onde o arquivo está salvo.

3. **Verifique a criação das tabelas**:
   Após a execução do script, você pode verificar se as tabelas foram criadas corretamente usando o comando:
   ```sql
   SHOW TABLES;
   ```

---

## Observações Adicionais

- **Dependências**: O script não possui dependências externas, mas é importante garantir que o MySQL esteja instalado e configurado corretamente.
- **Restrições**: As tabelas possuem restrições de integridade referencial. Ao excluir registros, tenha cuidado para não violar essas restrições.

---

## Contato

Caso tenha dúvidas ou sugestões, sinta-se à vontade para abrir uma *issue* ou enviar uma mensagem.
