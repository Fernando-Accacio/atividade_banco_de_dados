-- Los Gourmet Database DDL Script
-- Database: comanda_digital

-- Criação do banco de dados com suporte a caracteres UTF-8
CREATE DATABASE IF NOT EXISTS comanda_digital 
CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- Uso do banco de dados criado
USE comanda_digital;

-- Tabela 'categoria': armazena as categorias de produtos
-- Colunas:
-- - id: chave primária, identificador único da categoria
-- - nome: nome único para a categoria
CREATE TABLE categoria (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Tabela 'usuarios': armazena informações sobre os usuários do sistema
-- Colunas:
-- - id: chave primária, identificador único do usuário
-- - nome: nome do usuário
-- - email: endereço de e-mail único do usuário
-- - senha: senha do usuário, armazenada de forma segura (idealmente com hash)
-- - data_criacao: data de criação do registro, com valor padrão como a data atual
CREATE TABLE usuarios (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabela 'produtos': armazena informações dos produtos disponíveis
-- Colunas:
-- - id: chave primária, identificador único do produto
-- - nome: nome do produto
-- - preco: preço do produto
-- - descricao: descrição detalhada do produto
-- - categoria_id: chave estrangeira que referencia a tabela 'categoria'
-- - Restrição: ON DELETE SET NULL (categoria será definida como NULL caso excluída)
CREATE TABLE produtos (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    descricao TEXT,
    categoria_id BIGINT,
    FOREIGN KEY (categoria_id) REFERENCES categoria(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Tabela 'pedidos': registra os pedidos realizados pelos usuários
-- Colunas:
-- - id: chave primária, identificador único do pedido
-- - usuario_id: chave estrangeira que referencia a tabela 'usuarios'
-- - data_pedido: data e hora do pedido, com valor padrão como a data atual
-- - status: status do pedido (PENDENTE, CONFIRMADO, EM_PREPARO, CONCLUIDO)
-- - Restrição: ON DELETE CASCADE (exclui o pedido se o usuário for excluído)
CREATE TABLE pedidos (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    usuario_id BIGINT,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDENTE', 'CONFIRMADO', 'EM_PREPARO', 'CONCLUIDO') DEFAULT 'PENDENTE',
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela 'itens_pedido': armazena os itens de cada pedido
-- Colunas:
-- - id: chave primária, identificador único do item
-- - pedido_id: chave estrangeira que referencia a tabela 'pedidos'
-- - produto_id: chave estrangeira que referencia a tabela 'produtos'
-- - quantidade: quantidade do produto no pedido
-- - Restrições: ON DELETE CASCADE (exclui os itens se o pedido ou produto for excluído)
CREATE TABLE itens_pedido (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    pedido_id BIGINT,
    produto_id BIGINT,
    quantidade INT NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela 'comandas': controla as comandas abertas no restaurante
-- Colunas:
-- - id: chave primária, identificador único da comanda
-- - mesa: identificador da mesa associada à comanda
-- - data_abertura: data e hora de abertura da comanda
-- - data_fechamento: data e hora de fechamento da comanda (opcional)
-- - status: status da comanda (ABERTA, EM_PREPARO, PRONTA, FECHADA)
-- - valor_total: valor total da comanda
CREATE TABLE comandas (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    mesa VARCHAR(255) NOT NULL,
    data_abertura DATETIME(6) NOT NULL,
    data_fechamento DATETIME(6) DEFAULT NULL,
    status ENUM('ABERTA', 'EM_PREPARO', 'PRONTA', 'FECHADA') NOT NULL,
    valor_total DECIMAL(18,2) NOT NULL
) ENGINE=InnoDB;

-- Tabela 'itens_comanda': registra os itens de cada comanda
-- Colunas:
-- - id: chave primária, identificador único do item
-- - comanda_id: chave estrangeira que referencia a tabela 'comandas'
-- - produto_id: chave estrangeira que referencia a tabela 'produtos'
-- - quantidade: quantidade do produto na comanda
-- - preco_unitario: preço unitário do produto
-- - subtotal: subtotal do item (preço unitário * quantidade)
-- - observacao: observação adicional para o item
-- - Restrições: ON DELETE CASCADE (exclui os itens se a comanda ou produto for excluído)
CREATE TABLE itens_comanda (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    comanda_id BIGINT NOT NULL,
    produto_id BIGINT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(18,2) NOT NULL,
    subtotal DECIMAL(18,2) NOT NULL,
    observacao TEXT,
    FOREIGN KEY (comanda_id) REFERENCES comandas(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Índices para otimização de desempenho
-- Índice na tabela 'pedidos' para melhorar consultas por 'usuario_id'
CREATE INDEX idx_pedidos_usuario ON pedidos(usuario_id);

-- Índices na tabela 'itens_pedido' para melhorar consultas por 'pedido_id' e 'produto_id'
CREATE INDEX idx_itens_pedido_pedido ON itens_pedido(pedido_id);
CREATE INDEX idx_itens_pedido_produto ON itens_pedido(produto_id);

-- Índice na tabela 'produtos' para melhorar consultas por 'categoria_id'
CREATE INDEX idx_produtos_categoria ON produtos(categoria_id);
