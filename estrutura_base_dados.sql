-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           5.5.62-log - MySQL Community Server (GPL)
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para afero
CREATE DATABASE IF NOT EXISTS `afero` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `afero`;

-- Copiando estrutura para tabela afero.tbagrupamento
CREATE TABLE IF NOT EXISTS `tbagrupamento` (
  `idAgrupamento` smallint(6) NOT NULL AUTO_INCREMENT,
  `dsAgrupamento` varchar(40) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idAgrupamento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbanimal
CREATE TABLE IF NOT EXISTS `tbanimal` (
  `idAnimal` int(11) NOT NULL AUTO_INCREMENT,
  `cdEntidade` int(11) NOT NULL,
  `nmAnimal` varchar(50) NOT NULL,
  `cdTipoEspecie` int(11) NOT NULL,
  `idTipoRaca` smallint(6) NOT NULL,
  `dtNascimento` date DEFAULT NULL,
  `sexo` varchar(1) NOT NULL,
  `porte` varchar(1) DEFAULT NULL,
  `cor` varchar(20) DEFAULT NULL,
  `registro` varchar(20) DEFAULT NULL,
  `microchip` varchar(20) DEFAULT NULL,
  `passaporte` varchar(20) DEFAULT NULL,
  `origem` varchar(100) DEFAULT NULL,
  `estado` varchar(100) DEFAULT NULL,
  `alergia` varchar(100) DEFAULT NULL,
  `observacao` varchar(200) DEFAULT NULL,
  `pedigree` varchar(1) DEFAULT NULL,
  `obito` varchar(1) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idAnimal`),
  KEY `fk_tbAnimal_tbEntidade` (`cdEntidade`),
  KEY `fk_tbAnimal_tbTipoRaca` (`idTipoRaca`),
  KEY `fk_tbAnimal_tbTipoEspecie` (`cdTipoEspecie`),
  CONSTRAINT `fk_tbAnimal_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbAnimal_tbTipoEspecie` FOREIGN KEY (`cdTipoEspecie`) REFERENCES `tbtipoespecie` (`cdTipoEspecie`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbAnimal_tbTipoRaca` FOREIGN KEY (`idTipoRaca`) REFERENCES `tbtiporaca` (`idTipoRaca`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbanimalficha
CREATE TABLE IF NOT EXISTS `tbanimalficha` (
  `idAnimalFicha` int(11) NOT NULL AUTO_INCREMENT,
  `idAnimal` int(11) NOT NULL,
  `dtAtend` date NOT NULL,
  `descricao` varchar(400) NOT NULL,
  `peso` int(11) DEFAULT NULL,
  `altura` int(11) DEFAULT NULL,
  `observacao` varchar(200) DEFAULT NULL,
  `exame` varchar(400) DEFAULT NULL,
  `tipoAtividade` varchar(1) DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idAnimalFicha`),
  KEY `fk_tbAnimalFicha_tbAnimal` (`idAnimal`),
  CONSTRAINT `fk_tbAnimalFicha_tbAnimal` FOREIGN KEY (`idAnimal`) REFERENCES `tbanimal` (`idAnimal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbanimalmedicamento
CREATE TABLE IF NOT EXISTS `tbanimalmedicamento` (
  `idAnimalMedicamento` int(11) NOT NULL AUTO_INCREMENT,
  `idAnimalFicha` int(11) NOT NULL,
  `idMedicamento` int(11) NOT NULL,
  `nrLote` varchar(20) DEFAULT NULL,
  `dtFab` date DEFAULT NULL,
  `dtVal` date DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idAnimalMedicamento`),
  KEY `fk_tbAnimalMedicamento_tbAnimalFicha` (`idAnimalFicha`),
  KEY `fk_tbAnimalMedicamento_tbMedicamento` (`idMedicamento`),
  CONSTRAINT `fk_tbAnimalMedicamento_tbAnimalFicha` FOREIGN KEY (`idAnimalFicha`) REFERENCES `tbanimalficha` (`idAnimalFicha`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbAnimalMedicamento_tbMedicamento` FOREIGN KEY (`idMedicamento`) REFERENCES `tbmedicamento` (`idMedicamento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbanimalretorno
CREATE TABLE IF NOT EXISTS `tbanimalretorno` (
  `idAnimalRetorno` int(11) NOT NULL AUTO_INCREMENT,
  `idAnimal` int(11) NOT NULL,
  `dtRetorno` date NOT NULL,
  `descricao` varchar(100) NOT NULL,
  `lembrete` varchar(1) DEFAULT NULL,
  `avisoTempo` smallint(6) DEFAULT NULL,
  `avisoUnidade` varchar(1) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idAnimalRetorno`),
  KEY `fk_tbAnimalRetorno_tbAnimal` (`idAnimal`),
  CONSTRAINT `fk_tbAnimalRetorno_tbAnimal` FOREIGN KEY (`idAnimal`) REFERENCES `tbanimal` (`idAnimal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbareaatuacao
CREATE TABLE IF NOT EXISTS `tbareaatuacao` (
  `cdEntidade` int(11) NOT NULL,
  `idRamoAtividade` smallint(6) NOT NULL,
  PRIMARY KEY (`cdEntidade`,`idRamoAtividade`),
  KEY `fk_tbAreaAtuacao_tbEntidadeJuridica` (`cdEntidade`),
  KEY `fk_tbAreaAtuacao_tbRamoAtividade` (`idRamoAtividade`),
  CONSTRAINT `fk_tbAreaAtuacao_tbEntidadeJuridica` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidadejuridica` (`cdEntidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbAreaAtuacao_tbRamoAtividade` FOREIGN KEY (`idRamoAtividade`) REFERENCES `tbramoatividade` (`idRamoAtividade`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbbanco
CREATE TABLE IF NOT EXISTS `tbbanco` (
  `idBanco` smallint(6) NOT NULL AUTO_INCREMENT,
  `nmBanco` varchar(50) NOT NULL,
  `nrBanco` varchar(10) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idBanco`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcatalogo
CREATE TABLE IF NOT EXISTS `tbcatalogo` (
  `idCatalogo` int(11) NOT NULL AUTO_INCREMENT,
  `cdEntidade` int(11) NOT NULL,
  `idProduto` int(11) NOT NULL,
  `valor` float DEFAULT NULL,
  PRIMARY KEY (`idCatalogo`),
  KEY `fk_tbCatalogo_tbProduto` (`idProduto`),
  KEY `fk_tbCatalogo_tbEntidade` (`cdEntidade`),
  CONSTRAINT `fk_tbCatalogo_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbCatalogo_tbProduto` FOREIGN KEY (`idProduto`) REFERENCES `tbproduto` (`idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcattributaria
CREATE TABLE IF NOT EXISTS `tbcattributaria` (
  `idCatTributaria` int(11) NOT NULL AUTO_INCREMENT,
  `dsCatTributaria` varchar(100) DEFAULT NULL,
  `cdCstIpi` smallint(6) DEFAULT NULL,
  `pIpi` float DEFAULT NULL,
  `classeEnquadramento` varchar(5) DEFAULT NULL,
  `codigoEnquadramento` varchar(3) DEFAULT NULL,
  `cnpjProdutor` varchar(18) DEFAULT NULL,
  `cdCstPis` smallint(6) DEFAULT NULL,
  `pPis` float DEFAULT NULL,
  `cdCstCofins` smallint(6) DEFAULT NULL,
  `pCofins` float DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idCatTributaria`),
  KEY `fk_tbCatTributaria_tbCstIpi` (`cdCstIpi`),
  KEY `fk_tbCatTributaria_tbCstPis` (`cdCstPis`),
  KEY `fk_tbCatTributaria_tbCstCofins` (`cdCstCofins`),
  CONSTRAINT `fk_tbCatTributaria_tbCstCofins` FOREIGN KEY (`cdCstCofins`) REFERENCES `tbcstcofins` (`cdCstCofins`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbCatTributaria_tbCstIpi` FOREIGN KEY (`cdCstIpi`) REFERENCES `tbcstipi` (`cdCstIpi`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbCatTributaria_tbCstPis` FOREIGN KEY (`cdCstPis`) REFERENCES `tbcstpis` (`cdCstPis`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcentrocusto
CREATE TABLE IF NOT EXISTS `tbcentrocusto` (
  `idCentroCusto` smallint(6) NOT NULL AUTO_INCREMENT,
  `idCentroCustoPai` smallint(6) DEFAULT NULL,
  `nmCentroCusto` varchar(50) NOT NULL,
  `cdCentroCusto` varchar(20) NOT NULL,
  `pessoaResponsavel` varchar(60) DEFAULT NULL,
  `nroTelefone` varchar(15) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idCentroCusto`),
  KEY `fk_tbCentroCusto_tbCentroCusto` (`idCentroCustoPai`),
  CONSTRAINT `fk_tbCentroCusto_tbCentroCusto` FOREIGN KEY (`idCentroCustoPai`) REFERENCES `tbcentrocusto` (`idCentroCusto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcest
CREATE TABLE IF NOT EXISTS `tbcest` (
  `id_Cest` int(11) NOT NULL AUTO_INCREMENT,
  `nr_Cest` varchar(50) DEFAULT NULL,
  `ds_Cest` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`id_Cest`)
) ENGINE=InnoDB AUTO_INCREMENT=800 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcfop
CREATE TABLE IF NOT EXISTS `tbcfop` (
  `cdCfop` smallint(6) NOT NULL,
  `dsCfop` varchar(500) NOT NULL,
  `descricao` varchar(100) NOT NULL,
  `aplicacao` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`cdCfop`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbchequeemitido
CREATE TABLE IF NOT EXISTS `tbchequeemitido` (
  `idChequeEmitido` int(11) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `idConta` smallint(6) NOT NULL,
  `nrCheque` int(11) DEFAULT NULL,
  `valor` double DEFAULT NULL,
  `dtEmissao` date DEFAULT NULL,
  `dtVenc` date DEFAULT NULL,
  `favorecido` varchar(60) DEFAULT NULL,
  `cpfCnpj` varchar(18) DEFAULT NULL,
  `dtPagto` date DEFAULT NULL,
  `idContaMovto` bigint(20) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idChequeEmitido`),
  KEY `fk_tbChequeEmitido_tbConta` (`idConta`),
  KEY `fk_tbChequeEmitido_tbContaMovto` (`idContaMovto`),
  KEY `fk_tbChequeEmitido_tbLoja` (`idLoja`),
  CONSTRAINT `fk_tbChequeEmitido_tbConta` FOREIGN KEY (`idConta`) REFERENCES `tbconta` (`idConta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbChequeEmitido_tbContaMovto` FOREIGN KEY (`idContaMovto`) REFERENCES `tbcontamovto` (`idContaMovto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbChequeEmitido_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbchequerecebido
CREATE TABLE IF NOT EXISTS `tbchequerecebido` (
  `idChequeRecebido` int(11) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `cdEntidade` int(11) NOT NULL,
  `idBanco` smallint(6) NOT NULL,
  `agencia` varchar(6) DEFAULT NULL,
  `dvAgencia` varchar(1) DEFAULT NULL,
  `contaCorrente` varchar(10) DEFAULT NULL,
  `dvConta` varchar(1) DEFAULT NULL,
  `nrCheque` int(11) DEFAULT NULL,
  `valor` double DEFAULT NULL,
  `dtEmissao` date DEFAULT NULL,
  `dtVenc` date DEFAULT NULL,
  `correntista` varchar(60) DEFAULT NULL,
  `cpfCnpj` varchar(18) DEFAULT NULL,
  `destino` varchar(100) DEFAULT NULL,
  `observacao` varchar(100) DEFAULT NULL,
  `dtReceb` date DEFAULT NULL,
  `idContaMovto` bigint(20) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idChequeRecebido`),
  KEY `fk_tbChequeRecebido_tbEntidade` (`cdEntidade`),
  KEY `fk_tbChequeRecebido_tbBanco` (`idBanco`),
  KEY `fk_tbChequeRecebido_tbContaMovto` (`idContaMovto`),
  KEY `fk_tbChequeRecebido_tbLoja` (`idLoja`),
  CONSTRAINT `fk_tbChequeRecebido_tbBanco` FOREIGN KEY (`idBanco`) REFERENCES `tbbanco` (`idBanco`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbChequeRecebido_tbContaMovto` FOREIGN KEY (`idContaMovto`) REFERENCES `tbcontamovto` (`idContaMovto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbChequeRecebido_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbChequeRecebido_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcidade
CREATE TABLE IF NOT EXISTS `tbcidade` (
  `idCidade` smallint(6) NOT NULL AUTO_INCREMENT,
  `cdEstado` smallint(6) NOT NULL,
  `nmCidade` varchar(40) NOT NULL,
  `cdMunicipio` varchar(7) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idCidade`),
  KEY `fk_tbCidade_tbEstado` (`cdEstado`),
  CONSTRAINT `fk_tbCidade_tbEstado` FOREIGN KEY (`cdEstado`) REFERENCES `tbestado` (`cdEstado`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbclassificacao
CREATE TABLE IF NOT EXISTS `tbclassificacao` (
  `cdEntidade` int(11) NOT NULL,
  `idTipoEntidade` smallint(6) NOT NULL,
  PRIMARY KEY (`cdEntidade`,`idTipoEntidade`),
  KEY `fk_tbClassificacao_tbEntidade` (`cdEntidade`),
  KEY `fk_tbClassificacao_tbTipoEntidade` (`idTipoEntidade`),
  CONSTRAINT `fk_tbClassificacao_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbClassificacao_tbTipoEntidade` FOREIGN KEY (`idTipoEntidade`) REFERENCES `tbtipoentidade` (`idTipoEntidade`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcnae
CREATE TABLE IF NOT EXISTS `tbcnae` (
  `idCnae` int(10) DEFAULT NULL,
  `secao` varchar(100) DEFAULT '0',
  `divisao` varchar(100) DEFAULT '0',
  `grupo` varchar(100) DEFAULT '0',
  `classe` varchar(100) DEFAULT '0',
  `subclasse` varchar(100) DEFAULT '0',
  `denominacao` varchar(300) DEFAULT '0',
  KEY `idCnae` (`idCnae`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcolaborador
CREATE TABLE IF NOT EXISTS `tbcolaborador` (
  `idColaborador` int(11) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `idTipoColaborador` smallint(6) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `apelido` varchar(25) DEFAULT NULL,
  `endereco` varchar(40) DEFAULT NULL,
  `cep` varchar(10) DEFAULT NULL,
  `bairro` varchar(40) DEFAULT NULL,
  `cidade` varchar(40) DEFAULT NULL,
  `estado` varchar(2) DEFAULT NULL,
  `cmpEndereco` varchar(20) DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `nroRg` varchar(15) DEFAULT NULL,
  `orgRg` varchar(20) DEFAULT NULL,
  `ufRg` varchar(2) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `celular` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `tipoComissao` varchar(1) DEFAULT NULL,
  `taxaTabela` float DEFAULT NULL,
  `pDescAVista` float DEFAULT NULL,
  `pDescAPrazo` float DEFAULT NULL,
  `senha` varchar(20) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idColaborador`),
  KEY `fk_tbColaborador_tbLoja` (`idLoja`),
  KEY `fk_tbColaborador_tbTipoColaborador` (`idTipoColaborador`),
  KEY `fk_tbColaborador_tbLogin` (`idUsuario`),
  CONSTRAINT `fk_tbColaborador_tbLogin` FOREIGN KEY (`idUsuario`) REFERENCES `tbusuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbColaborador_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`),
  CONSTRAINT `fk_tbColaborador_tbTipoColaborador` FOREIGN KEY (`idTipoColaborador`) REFERENCES `tbtipocolaborador` (`idTipoColaborador`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcomissao
CREATE TABLE IF NOT EXISTS `tbcomissao` (
  `idComissao` int(11) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `tipoComissao` smallint(6) NOT NULL,
  `idColaborador` int(11) DEFAULT NULL,
  `idDivisao` int(11) DEFAULT NULL,
  `idSubGrupo` int(11) DEFAULT NULL,
  `idGrupo` int(11) DEFAULT NULL,
  `idProduto` int(11) DEFAULT NULL,
  `cdEntidade` int(11) DEFAULT NULL,
  `pComisAVista` float DEFAULT NULL,
  `pComisAPrazo` float DEFAULT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idComissao`),
  KEY `fk_tbComissao_tbColaborador` (`idColaborador`),
  KEY `fk_tbComissao_tbProduto` (`idProduto`),
  KEY `fk_tbComissao_tbEntidade` (`cdEntidade`),
  KEY `fk_tbComissao_tbLoja` (`idLoja`),
  KEY `fk_tbComissao_tbDivisao` (`idDivisao`),
  CONSTRAINT `fk_tbComissao_tbColaborador` FOREIGN KEY (`idColaborador`) REFERENCES `tbcolaborador` (`idColaborador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComissao_tbDivisao` FOREIGN KEY (`idDivisao`) REFERENCES `tbdivisao` (`idDivisao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComissao_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComissao_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbComissao_tbProduto` FOREIGN KEY (`idProduto`) REFERENCES `tbproduto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcondpagto
CREATE TABLE IF NOT EXISTS `tbcondpagto` (
  `cdCondPagto` int(11) NOT NULL AUTO_INCREMENT,
  `dsCondPagto` varchar(40) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`cdCondPagto`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbconfigboleto
CREATE TABLE IF NOT EXISTS `tbconfigboleto` (
  `idConta` smallint(6) NOT NULL,
  `localPagto` varchar(60) DEFAULT NULL,
  `especieDoc` varchar(2) DEFAULT NULL,
  `aceite` varchar(1) DEFAULT NULL,
  `carteira` varchar(6) DEFAULT NULL,
  `especie` varchar(3) DEFAULT NULL,
  `instrucao1` varchar(100) DEFAULT NULL,
  `instrucao2` varchar(100) DEFAULT NULL,
  `txMulta` float DEFAULT NULL,
  `txJuros` float DEFAULT NULL,
  KEY `fk_tbConfigBoleto_tbConta` (`idConta`),
  CONSTRAINT `fk_tbConfigBoleto_tbConta` FOREIGN KEY (`idConta`) REFERENCES `tbconta` (`idConta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbconfigcampo
CREATE TABLE IF NOT EXISTS `tbconfigcampo` (
  `idLoja` int(11) NOT NULL,
  `dsCmp1Entidade` varchar(20) DEFAULT NULL,
  `dsCmp2Entidade` varchar(20) DEFAULT NULL,
  `dsCmp3Entidade` varchar(20) DEFAULT NULL,
  `dsCmp4Entidade` varchar(20) DEFAULT NULL,
  `dsCmp5Entidade` varchar(20) DEFAULT NULL,
  `dsCmp1Produto` varchar(20) DEFAULT NULL,
  `dsCmp2Produto` varchar(20) DEFAULT NULL,
  `dsCmp3Produto` varchar(20) DEFAULT NULL,
  `dsCmp4Produto` varchar(20) DEFAULT NULL,
  `dsCmp5Produto` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idLoja`),
  CONSTRAINT `fk_tbConfigCampo_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbconfigcomanda
CREATE TABLE IF NOT EXISTS `tbconfigcomanda` (
  `idLoja` int(11) NOT NULL,
  `quantMesas` int(11) DEFAULT NULL,
  `pComissao` float DEFAULT NULL,
  `agruparItens` varchar(1) DEFAULT NULL,
  `balPorta` varchar(10) DEFAULT NULL,
  `balBitsSeg` int(11) DEFAULT NULL,
  `balBitsParada` int(11) DEFAULT NULL,
  `balBitsDados` int(11) DEFAULT NULL,
  `balParidade` varchar(10) DEFAULT NULL,
  `balSeqIni` int(11) DEFAULT NULL,
  `balFormato` varchar(10) DEFAULT NULL,
  `balInvPeso` varchar(1) DEFAULT NULL,
  `cdBarraTipo` varchar(1) DEFAULT NULL,
  `cdBarraDig` int(11) DEFAULT NULL,
  `cdBarraPos` int(11) DEFAULT NULL,
  `cdBaraTam` int(11) DEFAULT NULL,
  `cdBarraDec` int(11) DEFAULT NULL,
  PRIMARY KEY (`idLoja`),
  CONSTRAINT `fk_tbConfigComanda_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbconfiggeral
CREATE TABLE IF NOT EXISTS `tbconfiggeral` (
  `idLoja` int(11) NOT NULL,
  `menuModulo` varchar(400) DEFAULT NULL,
  `emailServidor` varchar(250) DEFAULT NULL,
  `emailPorta` varchar(10) DEFAULT NULL,
  `emailUsuario` varchar(40) DEFAULT NULL,
  `emailSenha` varchar(20) DEFAULT NULL,
  `integraPedidoSaidaFinan` varchar(2) DEFAULT 'N',
  PRIMARY KEY (`idLoja`),
  KEY `fk_tbConfigGeral_tbLoja` (`idLoja`),
  CONSTRAINT `fk_tbConfigGeral_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbconfigorcamento
CREATE TABLE IF NOT EXISTS `tbconfigorcamento` (
  `idLoja` int(11) NOT NULL,
  `dsCampo1` varchar(20) DEFAULT NULL,
  `dsCampo2` varchar(20) DEFAULT NULL,
  `dsCampo3` varchar(20) DEFAULT NULL,
  `dsCampo4` varchar(20) DEFAULT NULL,
  `msg1` varchar(100) DEFAULT NULL,
  `msg2` varchar(100) DEFAULT NULL,
  `msg3` varchar(100) DEFAULT NULL,
  `msg4` varchar(100) DEFAULT NULL,
  `msg5` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idLoja`),
  KEY `fk_tbConfigOrcamento_tbLoja` (`idLoja`),
  CONSTRAINT `fk_tbConfigOrcamento_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbconfigpedidosaida
CREATE TABLE IF NOT EXISTS `tbconfigpedidosaida` (
  `idLoja` int(11) NOT NULL,
  `dsCampo1` varchar(20) DEFAULT NULL,
  `dsCampo2` varchar(20) DEFAULT NULL,
  `dsCampo3` varchar(20) DEFAULT NULL,
  `dsCampo4` varchar(20) DEFAULT NULL,
  `msg1` varchar(100) DEFAULT NULL,
  `msg2` varchar(100) DEFAULT NULL,
  `msg3` varchar(100) DEFAULT NULL,
  `msg4` varchar(100) DEFAULT NULL,
  `msg5` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idLoja`),
  CONSTRAINT `fk_tbConfigPedidoSaida_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbconfigservico
CREATE TABLE IF NOT EXISTS `tbconfigservico` (
  `idLoja` int(11) NOT NULL,
  `tipoOS` varchar(1) DEFAULT NULL,
  `dsCampo1` varchar(20) DEFAULT NULL,
  `dsCampo2` varchar(20) DEFAULT NULL,
  `dsCampo3` varchar(20) DEFAULT NULL,
  `dsCampo4` varchar(20) DEFAULT NULL,
  `msg1` varchar(100) DEFAULT NULL,
  `msg2` varchar(100) DEFAULT NULL,
  `msg3` varchar(100) DEFAULT NULL,
  `msg4` varchar(100) DEFAULT NULL,
  `msg5` varchar(100) DEFAULT NULL,
  `pCSocial` float DEFAULT NULL,
  `pCofins` float DEFAULT NULL,
  `pPis` float DEFAULT NULL,
  `pIrrf` float DEFAULT NULL,
  `tetoIrrf` float DEFAULT NULL,
  `pInss` float DEFAULT NULL,
  `pIss` float DEFAULT NULL,
  `cdCfopServico` smallint(6) DEFAULT NULL,
  `cdCfopProduto` smallint(6) DEFAULT NULL,
  `dsCmpOb1` varchar(20) DEFAULT NULL,
  `dsCmpOb2` varchar(20) DEFAULT NULL,
  `dsCmpOb3` varchar(30) DEFAULT NULL,
  `dsCmpOb4` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idLoja`),
  KEY `fk_tbConfigServico_tbCfop1` (`cdCfopServico`),
  KEY `fk_tbConfigServico_tbCfop2` (`cdCfopProduto`),
  KEY `fk_tbConfigServico_tbLoja` (`idLoja`),
  CONSTRAINT `fk_tbConfigServico_tbCfop1` FOREIGN KEY (`cdCfopServico`) REFERENCES `tbcfop` (`cdCfop`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbConfigServico_tbCfop2` FOREIGN KEY (`cdCfopProduto`) REFERENCES `tbcfop` (`cdCfop`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbConfigServico_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbconfigsistema
CREATE TABLE IF NOT EXISTS `tbconfigsistema` (
  `versaoBD` varchar(10) DEFAULT NULL,
  `logomarca` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbconta
CREATE TABLE IF NOT EXISTS `tbconta` (
  `idConta` smallint(6) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `nmConta` varchar(50) NOT NULL,
  `idTipoConta` smallint(6) NOT NULL,
  `idBanco` smallint(6) DEFAULT NULL,
  `agencia` varchar(6) DEFAULT NULL,
  `dvAgencia` varchar(1) DEFAULT NULL,
  `contaCorrente` varchar(10) DEFAULT NULL,
  `dvConta` varchar(1) DEFAULT NULL,
  `vlLimiteCredito` double DEFAULT NULL,
  `dtVencLimite` date DEFAULT NULL,
  `dtSaldoAbertura` date DEFAULT NULL,
  `vlSaldoAbertura` double DEFAULT NULL,
  `paginaInicial` varchar(1) NOT NULL,
  `status` varchar(1) NOT NULL,
  `pessoaContato` varchar(60) DEFAULT NULL,
  `nroTelefone` varchar(15) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `site` varchar(60) DEFAULT NULL,
  `observacao` varchar(200) DEFAULT NULL,
  `dtSaldoAtual` timestamp NULL DEFAULT NULL,
  `vlSaldoAtual` double DEFAULT NULL,
  `dtSaldoConciliado` timestamp NULL DEFAULT NULL,
  `vlSaldoConciliado` double DEFAULT NULL,
  `dtMovtoCaixa` date DEFAULT NULL,
  `statusCaixa` varchar(1) DEFAULT NULL,
  `dtCad` timestamp NULL DEFAULT NULL,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idConta`),
  KEY `fk_tbConta_tbTipoConta` (`idTipoConta`),
  KEY `fk_tbConta_tbBanco` (`idBanco`),
  KEY `fk_tbConta_tbLoja` (`idLoja`),
  CONSTRAINT `fk_tbConta_tbBanco` FOREIGN KEY (`idBanco`) REFERENCES `tbbanco` (`idBanco`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbConta_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbConta_tbTipoConta` FOREIGN KEY (`idTipoConta`) REFERENCES `tbtipoconta` (`idTipoConta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcontamovto
CREATE TABLE IF NOT EXISTS `tbcontamovto` (
  `idContaMovto` bigint(20) NOT NULL AUTO_INCREMENT,
  `idConta` smallint(6) NOT NULL,
  `dc` varchar(1) NOT NULL,
  `valor` double NOT NULL,
  `formaMovto` varchar(2) NOT NULL,
  `dtLanc` date NOT NULL,
  `dtComp` date DEFAULT NULL,
  `idTransferencia` bigint(20) DEFAULT NULL,
  `nrDoc` varchar(20) DEFAULT NULL,
  `idPlanoConta` smallint(6) DEFAULT NULL,
  `idCentroCusto` smallint(6) DEFAULT NULL,
  `historico` varchar(200) DEFAULT NULL,
  `divideValor` varchar(1) DEFAULT NULL,
  `idColaborador` int(11) DEFAULT NULL,
  `vlSaldoAnterior` double DEFAULT NULL,
  `vlSaldoAtual` double DEFAULT NULL,
  `conciliado` varchar(1) DEFAULT NULL,
  `cdFormaPagto` smallint(6) DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idContaMovto`),
  KEY `fk_tbContaMovto_tbConta` (`idConta`),
  KEY `fk_tbContaMovto_tbPlanoConta` (`idPlanoConta`),
  KEY `fk_tbContaMovto_tbCentroCusto` (`idCentroCusto`),
  KEY `fk_tbContaMovto_tbColaborador` (`idColaborador`),
  KEY `fk_tbContaMovto_tbTransferencia` (`idTransferencia`),
  KEY `fk_tbContaMovto_tbFormaPagto` (`cdFormaPagto`),
  CONSTRAINT `fk_tbContaMovto_tbCentroCusto` FOREIGN KEY (`idCentroCusto`) REFERENCES `tbcentrocusto` (`idCentroCusto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbContaMovto_tbColaborador` FOREIGN KEY (`idColaborador`) REFERENCES `tbcolaborador` (`idColaborador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbContaMovto_tbConta` FOREIGN KEY (`idConta`) REFERENCES `tbconta` (`idConta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbContaMovto_tbPlanoConta` FOREIGN KEY (`idPlanoConta`) REFERENCES `tbplanoconta` (`idPlanoConta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbContaMovto_tbTransferencia` FOREIGN KEY (`idTransferencia`) REFERENCES `tbtransferencia` (`idTransferencia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcontamovtodivisao
CREATE TABLE IF NOT EXISTS `tbcontamovtodivisao` (
  `idContaMovtoDivisao` bigint(20) NOT NULL AUTO_INCREMENT,
  `idContaMovto` bigint(20) NOT NULL,
  `idPlanoConta` smallint(6) DEFAULT NULL,
  `idCentroCusto` smallint(6) DEFAULT NULL,
  `observacao` varchar(100) DEFAULT NULL,
  `valor` float DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idContaMovtoDivisao`),
  KEY `fk_tbContaMovtoDivisao_tbContaMovto` (`idContaMovto`),
  KEY `fk_tbContaMovtoDivisao_tbPlanoConta` (`idPlanoConta`),
  KEY `fk_tbContaMovtoDivisao_tbCentroCusto` (`idCentroCusto`),
  CONSTRAINT `fk_tbContaMovtoDivisao_tbCentroCusto` FOREIGN KEY (`idCentroCusto`) REFERENCES `tbcentrocusto` (`idCentroCusto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbContaMovtoDivisao_tbContaMovto` FOREIGN KEY (`idContaMovto`) REFERENCES `tbcontamovto` (`idContaMovto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbContaMovtoDivisao_tbPlanoConta` FOREIGN KEY (`idPlanoConta`) REFERENCES `tbplanoconta` (`idPlanoConta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcotacao
CREATE TABLE IF NOT EXISTS `tbcotacao` (
  `idCotacao` bigint(20) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `idColaborador` int(11) NOT NULL,
  `dtCotacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `observacao` varchar(100) DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuaio` varchar(20) NOT NULL,
  PRIMARY KEY (`idCotacao`),
  KEY `fk_tbCotacao_tbColaborador` (`idColaborador`),
  KEY `fk_tbCotacao_tbLoja` (`idLoja`),
  CONSTRAINT `fk_tbCotacao_tbColaborador` FOREIGN KEY (`idColaborador`) REFERENCES `tbcolaborador` (`idColaborador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbCotacao_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcotacaoentidade
CREATE TABLE IF NOT EXISTS `tbcotacaoentidade` (
  `idCotacaoEntidade` bigint(20) NOT NULL AUTO_INCREMENT,
  `idCotacaoItem` bigint(20) NOT NULL,
  `cdEntidade` int(11) NOT NULL,
  `valor` float DEFAULT NULL,
  `prazoEntrega` smallint(6) DEFAULT NULL,
  `aprovado` varchar(1) NOT NULL,
  `valorAprov` float DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idCotacaoEntidade`),
  KEY `fk_tbCotacaoEntidade_tbCotacaoItem` (`idCotacaoItem`),
  KEY `fk_tbCotacaoEntidade_tbEntidade` (`cdEntidade`),
  CONSTRAINT `fk_tbCotacaoEntidade_tbCotacaoItem` FOREIGN KEY (`idCotacaoItem`) REFERENCES `tbcotacaoitem` (`idCotacaoItem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbCotacaoEntidade_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcotacaoitem
CREATE TABLE IF NOT EXISTS `tbcotacaoitem` (
  `idCotacaoItem` bigint(20) NOT NULL AUTO_INCREMENT,
  `idCotacao` bigint(20) NOT NULL,
  `idProduto` int(11) NOT NULL,
  `idUnidade` int(11) NOT NULL,
  `quant` float DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idCotacaoItem`),
  KEY `fk_tbCotacaoItem_tbCotacao` (`idCotacao`),
  KEY `fk_tbCotacaoItem_tbProduto` (`idProduto`),
  KEY `fk_tbCotacaoItem_tbUnidade` (`idUnidade`),
  CONSTRAINT `fk_tbCotacaoItem_tbCotacao` FOREIGN KEY (`idCotacao`) REFERENCES `tbcotacao` (`idCotacao`),
  CONSTRAINT `fk_tbCotacaoItem_tbProduto` FOREIGN KEY (`idProduto`) REFERENCES `tbproduto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbCotacaoItem_tbUnidade` FOREIGN KEY (`idUnidade`) REFERENCES `tbunidade` (`idUnidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcotacaopedidoentrada
CREATE TABLE IF NOT EXISTS `tbcotacaopedidoentrada` (
  `idCotacao` bigint(20) NOT NULL,
  `idPedidoEntrada` bigint(20) NOT NULL,
  PRIMARY KEY (`idCotacao`,`idPedidoEntrada`),
  KEY `fk_tbCotacaoPedidoEntrada_tbCotacao` (`idCotacao`),
  KEY `fk_tbCotacaoPedidoEntrada_tbPedidoEntrada` (`idPedidoEntrada`),
  CONSTRAINT `fk_tbCotacaoPedidoEntrada_tbCotacao` FOREIGN KEY (`idCotacao`) REFERENCES `tbcotacao` (`idCotacao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbCotacaoPedidoEntrada_tbPedidoEntrada` FOREIGN KEY (`idPedidoEntrada`) REFERENCES `tbpedidoentrada` (`idPedidoEntrada`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcrt
CREATE TABLE IF NOT EXISTS `tbcrt` (
  `idCrt` int(10) NOT NULL AUTO_INCREMENT,
  `codigo` int(3) NOT NULL DEFAULT '0',
  `descricao` varchar(200) NOT NULL DEFAULT '0',
  KEY `idCrt` (`idCrt`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Segue a tabela de CRT';

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcsosn
CREATE TABLE IF NOT EXISTS `tbcsosn` (
  `cdCsosn` smallint(6) NOT NULL,
  `dsCsosn` varchar(100) NOT NULL,
  PRIMARY KEY (`cdCsosn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcstcofins
CREATE TABLE IF NOT EXISTS `tbcstcofins` (
  `cdCstCofins` smallint(6) NOT NULL,
  `dsCstCofins` varchar(100) NOT NULL,
  PRIMARY KEY (`cdCstCofins`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcsticms
CREATE TABLE IF NOT EXISTS `tbcsticms` (
  `cdCstIcms` smallint(6) NOT NULL,
  `dsCstIcms` varchar(100) NOT NULL,
  PRIMARY KEY (`cdCstIcms`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcstipi
CREATE TABLE IF NOT EXISTS `tbcstipi` (
  `cdCstIpi` smallint(6) NOT NULL,
  `dsCstIpi` varchar(100) NOT NULL,
  PRIMARY KEY (`cdCstIpi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbcstpis
CREATE TABLE IF NOT EXISTS `tbcstpis` (
  `cdCstPis` smallint(6) NOT NULL,
  `dsCstPis` varchar(100) NOT NULL,
  PRIMARY KEY (`cdCstPis`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbdivisao
CREATE TABLE IF NOT EXISTS `tbdivisao` (
  `idDivisao` int(11) NOT NULL AUTO_INCREMENT,
  `idSubGrupo` int(11) NOT NULL,
  `idGrupo` int(11) NOT NULL,
  `dsDivisao` varchar(40) NOT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idDivisao`),
  KEY `fk_tbDivisao_tbSubGrupo` (`idSubGrupo`),
  CONSTRAINT `fk_tbDivisao_tbSubGrupo` FOREIGN KEY (`idSubGrupo`) REFERENCES `tbsubgrupo` (`idSubGrupo`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbduplicata
CREATE TABLE IF NOT EXISTS `tbduplicata` (
  `idDuplicata` bigint(20) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `cdEntidade` int(11) NOT NULL,
  `dc` varchar(1) NOT NULL,
  `dtEmissao` date NOT NULL,
  `dtComp` date DEFAULT NULL,
  `nrDoc` varchar(20) DEFAULT NULL,
  `idTipoDocumento` smallint(6) DEFAULT NULL,
  `idPlanoConta` smallint(6) DEFAULT NULL,
  `idCentroCusto` smallint(6) DEFAULT NULL,
  `historico` varchar(200) DEFAULT NULL,
  `nrDiasPag` smallint(6) DEFAULT NULL,
  `quantParcelas` smallint(6) DEFAULT NULL,
  `valorTotal` double NOT NULL,
  `geraBoleto` varchar(1) DEFAULT NULL,
  `observacao` varchar(200) DEFAULT NULL,
  `tipoLancamento` varchar(1) DEFAULT NULL,
  `txMulta` float DEFAULT NULL,
  `txJuros` float DEFAULT NULL,
  `tipoJuros` varchar(1) DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idDuplicata`),
  KEY `fk_tbDuplicata_tbEntidade` (`cdEntidade`),
  KEY `fk_tbDuplicata_tbPlanoConta` (`idPlanoConta`),
  KEY `fk_tbDuplicata_tbCentroCusto` (`idCentroCusto`),
  KEY `fk_tbDuplicata_tbTipoDocumento` (`idTipoDocumento`),
  KEY `fk_tbDuplicata_tbLoja` (`idLoja`),
  CONSTRAINT `fk_tbDuplicata_tbCentroCusto` FOREIGN KEY (`idCentroCusto`) REFERENCES `tbcentrocusto` (`idCentroCusto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbDuplicata_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbDuplicata_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbDuplicata_tbPlanoConta` FOREIGN KEY (`idPlanoConta`) REFERENCES `tbplanoconta` (`idPlanoConta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbDuplicata_tbTipoDocumento` FOREIGN KEY (`idTipoDocumento`) REFERENCES `tbtipodocumento` (`idTipoDocumento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbduplicatadivisao
CREATE TABLE IF NOT EXISTS `tbduplicatadivisao` (
  `idDuplicataDivisao` bigint(20) NOT NULL AUTO_INCREMENT,
  `idDuplicataParcela` bigint(20) NOT NULL,
  `idPlanoConta` smallint(6) DEFAULT NULL,
  `idCentroCusto` smallint(6) DEFAULT NULL,
  `observacao` varchar(100) DEFAULT NULL,
  `valor` float DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idDuplicataDivisao`),
  KEY `fk_tbDuplicataDivisao_tbPlanoConta` (`idPlanoConta`),
  KEY `fk_tbDuplicataDivisao_tbCentroCusto` (`idCentroCusto`),
  KEY `fk_tbDuplicataDivisao_tbDuplicataParcela` (`idDuplicataParcela`),
  CONSTRAINT `fk_tbDuplicataDivisao_tbCentroCusto` FOREIGN KEY (`idCentroCusto`) REFERENCES `tbcentrocusto` (`idCentroCusto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbDuplicataDivisao_tbDuplicataParcela` FOREIGN KEY (`idDuplicataParcela`) REFERENCES `tbduplicataparcela` (`idDuplicataParcela`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbDuplicataDivisao_tbPlanoConta` FOREIGN KEY (`idPlanoConta`) REFERENCES `tbplanoconta` (`idPlanoConta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbduplicataparcela
CREATE TABLE IF NOT EXISTS `tbduplicataparcela` (
  `idDuplicataParcela` bigint(20) NOT NULL AUTO_INCREMENT,
  `idDuplicata` bigint(20) NOT NULL,
  `nrParcela` smallint(6) NOT NULL,
  `idConta` smallint(6) NOT NULL,
  `dtVenc` date NOT NULL,
  `valor` double NOT NULL,
  `cdFormaPagto` smallint(6) DEFAULT NULL,
  `dtEmissao` date NOT NULL,
  `dtComp` date DEFAULT NULL,
  `nrDoc` varchar(20) DEFAULT NULL,
  `idPlanoConta` smallint(6) DEFAULT NULL,
  `idCentroCusto` smallint(6) DEFAULT NULL,
  `historico` varchar(200) DEFAULT NULL,
  `divideValor` varchar(1) DEFAULT NULL,
  `dtOperacao` date DEFAULT NULL,
  `vlOperacao` double DEFAULT NULL,
  `vlJuros` float DEFAULT NULL,
  `vlMulta` float DEFAULT NULL,
  `vlDesc` float DEFAULT NULL,
  `dtBoleto` date DEFAULT NULL,
  `especieDoc` varchar(2) DEFAULT NULL,
  `aceite` varchar(1) DEFAULT NULL,
  `nossoNumero` varchar(20) DEFAULT NULL,
  `instrucao` varchar(100) DEFAULT NULL,
  `chaveASBACE` varchar(25) DEFAULT NULL,
  `linhaDigitavel` varchar(50) DEFAULT NULL,
  `cdBarra` varchar(50) DEFAULT NULL,
  `dtQuitacao` date DEFAULT NULL,
  `formaQuitacao` varchar(1) DEFAULT NULL,
  `idColaborador` int(11) DEFAULT NULL,
  `atualizaFinanceiro` varchar(1) DEFAULT NULL,
  `idContaMovto` bigint(20) DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `dtMov` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idDuplicataParcela`),
  KEY `fk_tbDuplicataParcela_tbDuplicata` (`idDuplicata`),
  KEY `fk_tbDuplicataParcela_tbConta` (`idConta`),
  KEY `fk_tbDuplicataParcela_tbPlanoConta` (`idPlanoConta`),
  KEY `fk_tbDuplicataParcela_tbCentroCusto` (`idCentroCusto`),
  KEY `fk_tbDuplicataParcela_tbContaMovto` (`idContaMovto`),
  KEY `fk_tbDuplicataParcela_tbFormaPagto` (`cdFormaPagto`),
  KEY `fk_tbDuplicataParcela_tbColaborador` (`idColaborador`),
  CONSTRAINT `fk_tbDuplicataParcela_tbCentroCusto` FOREIGN KEY (`idCentroCusto`) REFERENCES `tbcentrocusto` (`idCentroCusto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbDuplicataParcela_tbColaborador` FOREIGN KEY (`idColaborador`) REFERENCES `tbcolaborador` (`idColaborador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbDuplicataParcela_tbConta` FOREIGN KEY (`idConta`) REFERENCES `tbconta` (`idConta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbDuplicataParcela_tbContaMovto` FOREIGN KEY (`idContaMovto`) REFERENCES `tbcontamovto` (`idContaMovto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbDuplicataParcela_tbDuplicata` FOREIGN KEY (`idDuplicata`) REFERENCES `tbduplicata` (`idDuplicata`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbDuplicataParcela_tbFormaPagto` FOREIGN KEY (`cdFormaPagto`) REFERENCES `tbformapagto` (`cdFormaPagto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbDuplicataParcela_tbPlanoConta` FOREIGN KEY (`idPlanoConta`) REFERENCES `tbplanoconta` (`idPlanoConta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbentidade
CREATE TABLE IF NOT EXISTS `tbentidade` (
  `cdEntidade` int(11) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `tpInsc` varchar(1) NOT NULL,
  `site` varchar(60) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `observacao` varchar(100) DEFAULT NULL,
  `bloqueio` varchar(1) NOT NULL,
  `idColaborador` int(11) DEFAULT NULL,
  `campo1` varchar(50) DEFAULT NULL,
  `campo2` varchar(50) DEFAULT NULL,
  `campo3` varchar(50) DEFAULT NULL,
  `campo4` varchar(50) DEFAULT NULL,
  `campo5` varchar(50) DEFAULT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`cdEntidade`),
  KEY `fk_tbEntidade_tbColaborador` (`idColaborador`),
  CONSTRAINT `fk_tbEntidade_tbColaborador` FOREIGN KEY (`idColaborador`) REFERENCES `tbcolaborador` (`idColaborador`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbentidadecontato
CREATE TABLE IF NOT EXISTS `tbentidadecontato` (
  `idEntidadeContato` int(11) NOT NULL AUTO_INCREMENT,
  `cdEntidade` int(11) NOT NULL,
  `cdTipoNivel` smallint(6) NOT NULL,
  `nmContato` varchar(60) NOT NULL,
  `dtNascimento` date DEFAULT NULL,
  `cargo` varchar(40) DEFAULT NULL,
  `departamento` varchar(40) DEFAULT NULL,
  `sexo` varchar(1) NOT NULL,
  `telefone1` varchar(15) DEFAULT NULL,
  `ramal1` varchar(5) DEFAULT NULL,
  `telefone2` varchar(15) DEFAULT NULL,
  `ramal2` varchar(5) DEFAULT NULL,
  `fax` varchar(15) DEFAULT NULL,
  `celular` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `hobby` varchar(25) DEFAULT NULL,
  `time` varchar(25) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idEntidadeContato`),
  KEY `fk_EntidadeContato_tbEntidadeJuridica` (`cdEntidade`),
  KEY `fk_EntidadeContato_tbTipoNivel` (`cdTipoNivel`),
  CONSTRAINT `fk_EntidadeContato_tbEntidadeJuridica` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidadejuridica` (`cdEntidade`),
  CONSTRAINT `fk_EntidadeContato_tbTipoNivel` FOREIGN KEY (`cdTipoNivel`) REFERENCES `tbtiponivel` (`cdTipoNivel`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbentidadedependente
CREATE TABLE IF NOT EXISTS `tbentidadedependente` (
  `idEntidadeDependente` int(11) NOT NULL AUTO_INCREMENT,
  `cdEntidade` int(11) NOT NULL,
  `idTipoDependente` smallint(6) NOT NULL,
  `nmDependente` varchar(60) NOT NULL,
  `dtNascimento` date DEFAULT NULL,
  `sexo` varchar(1) NOT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idEntidadeDependente`),
  KEY `fk_tbEntidadeDependente_tbEntidadeFisica` (`cdEntidade`),
  KEY `fk_tbEntidadeDependente_tbTipoDependente` (`idTipoDependente`),
  CONSTRAINT `fk_tbEntidadeDependente_tbEntidadeFisica` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidadefisica` (`cdEntidade`),
  CONSTRAINT `fk_tbEntidadeDependente_tbTipoDependente` FOREIGN KEY (`idTipoDependente`) REFERENCES `tbtipodependente` (`idTipoDependente`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbentidadeemail
CREATE TABLE IF NOT EXISTS `tbentidadeemail` (
  `idEntidadeEmail` int(11) NOT NULL AUTO_INCREMENT,
  `cdEntidade` int(11) NOT NULL,
  `cdTipoEmail` smallint(6) NOT NULL,
  `dsEmail` varchar(100) NOT NULL,
  `padrao` varchar(1) NOT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idEntidadeEmail`),
  KEY `fk_tbEntidadeEmail_tbEntidade` (`cdEntidade`),
  KEY `fk_tbEntidadeEmail_tbTipoEmail` (`cdTipoEmail`),
  CONSTRAINT `fk_tbEntidadeEmail_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`),
  CONSTRAINT `fk_tbEntidadeEmail_tbTipoEmail` FOREIGN KEY (`cdTipoEmail`) REFERENCES `tbtipoemail` (`cdTipoEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=49949 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbentidadeendereco
CREATE TABLE IF NOT EXISTS `tbentidadeendereco` (
  `idEntidadeEndereco` int(11) NOT NULL AUTO_INCREMENT,
  `cdEntidade` int(11) NOT NULL,
  `cdTipoEndereco` smallint(6) NOT NULL,
  `cdTipoLogradouro` smallint(6) NOT NULL,
  `idCidade` smallint(6) NOT NULL,
  `dsEndereco` varchar(40) NOT NULL,
  `nroEndereco` varchar(5) DEFAULT NULL,
  `cmpEndereco` varchar(40) DEFAULT NULL,
  `baiEndereco` varchar(40) DEFAULT NULL,
  `cepEndereco` varchar(10) DEFAULT NULL,
  `cxpEndereco` varchar(10) DEFAULT NULL,
  `refEndereco` varchar(50) DEFAULT NULL,
  `padrao` varchar(1) NOT NULL,
  `idEntrega` int(11) DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idEntidadeEndereco`),
  KEY `fk_tbEntidadeEndereco_tbEntidade` (`cdEntidade`),
  KEY `fk_tbEntidadeEndereco_tbTipoLogradouro` (`cdTipoLogradouro`),
  KEY `fk_tbEntidadeEndereco_tbCidade` (`idCidade`),
  KEY `fk_tbEntidadeEndereco_tbTipoEndereco` (`cdTipoEndereco`),
  KEY `fk_tbEntidadeEndereco_tbEntrega` (`idEntrega`),
  CONSTRAINT `fk_tbEntidadeEndereco_tbCidade` FOREIGN KEY (`idCidade`) REFERENCES `tbcidade` (`idCidade`),
  CONSTRAINT `fk_tbEntidadeEndereco_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`),
  CONSTRAINT `fk_tbEntidadeEndereco_tbEntrega` FOREIGN KEY (`idEntrega`) REFERENCES `tbentrega` (`idEntrega`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbEntidadeEndereco_tbTipoEndereco` FOREIGN KEY (`cdTipoEndereco`) REFERENCES `tbtipoendereco` (`cdTipoEndereco`),
  CONSTRAINT `fk_tbEntidadeEndereco_tbTipoLogradouro` FOREIGN KEY (`cdTipoLogradouro`) REFERENCES `tbtipologradouro` (`cdTipoLogradouro`)
) ENGINE=InnoDB AUTO_INCREMENT=59175 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbentidadefisica
CREATE TABLE IF NOT EXISTS `tbentidadefisica` (
  `cdEntidade` int(11) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `dtNascimento` date DEFAULT NULL,
  `dtCasamento` date DEFAULT NULL,
  `Cargo` varchar(40) DEFAULT NULL,
  `Departamento` varchar(40) DEFAULT NULL,
  `Empresa` varchar(60) DEFAULT NULL,
  `sexo` varchar(1) NOT NULL,
  `cdEstadoCivil` smallint(6) NOT NULL,
  `cdEscolaridade` smallint(6) NOT NULL,
  `cpfConjuge` varchar(14) DEFAULT NULL,
  `conjuge` varchar(40) DEFAULT NULL,
  `mae` varchar(40) DEFAULT NULL,
  `pai` varchar(40) DEFAULT NULL,
  `nroRg` varchar(15) DEFAULT NULL,
  `OrgRg` varchar(20) DEFAULT NULL,
  `ufRg` varchar(2) DEFAULT NULL,
  `dtRg` date DEFAULT NULL,
  `hobby` varchar(25) DEFAULT NULL,
  `time` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`cdEntidade`),
  KEY `fk_tbEntidadeFisica_tbEntidade` (`cdEntidade`),
  KEY `fk_tbEntidadeFisica_tbEstadoCivil` (`cdEstadoCivil`),
  KEY `fk_tbEntidadeFisica_tbEscolaridade` (`cdEscolaridade`),
  CONSTRAINT `fk_tbEntidadeFisica_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`),
  CONSTRAINT `fk_tbEntidadeFisica_tbEscolaridade` FOREIGN KEY (`cdEscolaridade`) REFERENCES `tbescolaridade` (`cdEscolaridade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbEntidadeFisica_tbEstadoCivil` FOREIGN KEY (`cdEstadoCivil`) REFERENCES `tbestadocivil` (`cdEstadoCivil`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbentidadejuridica
CREATE TABLE IF NOT EXISTS `tbentidadejuridica` (
  `cdEntidade` int(11) NOT NULL,
  `cnpj` varchar(18) NOT NULL,
  `razaoSocial` varchar(60) NOT NULL,
  `dtAbertura` date DEFAULT NULL,
  `InscEstadual` varchar(15) DEFAULT NULL,
  `codCnae` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`cdEntidade`),
  CONSTRAINT `fk_tbEntidadeJuridica_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbentidadetelefone
CREATE TABLE IF NOT EXISTS `tbentidadetelefone` (
  `idEntidadeTelefone` int(11) NOT NULL AUTO_INCREMENT,
  `cdEntidade` int(11) NOT NULL,
  `cdTipoTelefone` smallint(6) NOT NULL,
  `nroTelefone` varchar(15) DEFAULT NULL,
  `ramTelefone` varchar(5) DEFAULT NULL,
  `padrao` varchar(1) NOT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idEntidadeTelefone`),
  KEY `fk_tbEntidadeTelefone_tbEntidade` (`cdEntidade`),
  KEY `fk_tbEntidadeTelefone_tbTipoTelefone` (`cdTipoTelefone`),
  CONSTRAINT `fk_tbEntidadeTelefone_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`),
  CONSTRAINT `fk_tbEntidadeTelefone_tbTipoTelefone` FOREIGN KEY (`cdTipoTelefone`) REFERENCES `tbtipotelefone` (`cdTipoTelefone`)
) ENGINE=InnoDB AUTO_INCREMENT=71472 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbentrega
CREATE TABLE IF NOT EXISTS `tbentrega` (
  `idEntrega` int(11) NOT NULL AUTO_INCREMENT,
  `dsEntrega` varchar(50) NOT NULL,
  `txEntrega` float DEFAULT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idEntrega`)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbescolaridade
CREATE TABLE IF NOT EXISTS `tbescolaridade` (
  `cdEscolaridade` smallint(6) NOT NULL,
  `dsEscolaridade` varchar(50) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`cdEscolaridade`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbestado
CREATE TABLE IF NOT EXISTS `tbestado` (
  `cdEstado` smallint(6) NOT NULL,
  `cdRegiao` smallint(6) DEFAULT NULL,
  `cdPais` smallint(6) DEFAULT NULL,
  `siglaEstado` varchar(2) DEFAULT NULL,
  `ufEstado` varchar(40) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`cdEstado`),
  KEY `fk_tbEstado_tbRegiao` (`cdRegiao`),
  KEY `fk_tbEstado_tbPais` (`cdPais`),
  CONSTRAINT `fk_tbEstado_tbPais` FOREIGN KEY (`cdPais`) REFERENCES `tbpais` (`cdPais`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbEstado_tbRegiao` FOREIGN KEY (`cdRegiao`) REFERENCES `tbregiao` (`cdRegiao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbestadocivil
CREATE TABLE IF NOT EXISTS `tbestadocivil` (
  `cdEstadoCivil` smallint(6) NOT NULL,
  `dsEstadoCivil` varchar(20) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`cdEstadoCivil`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbestoque
CREATE TABLE IF NOT EXISTS `tbestoque` (
  `idEstoque` int(11) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `idProduto` int(11) NOT NULL,
  `qtEstoque` double DEFAULT NULL,
  `qtMinimo` double DEFAULT NULL,
  `qtMaxima` double DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idEstoque`),
  KEY `fk_tbEstoque_tbLoja` (`idLoja`),
  KEY `fk_tbEstoque_tbProduto` (`idProduto`),
  CONSTRAINT `fk_tbEstoque_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`),
  CONSTRAINT `fk_tbEstoque_tbProduto` FOREIGN KEY (`idProduto`) REFERENCES `tbproduto` (`idProduto`)
) ENGINE=InnoDB AUTO_INCREMENT=7402 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbformacaopreco
CREATE TABLE IF NOT EXISTS `tbformacaopreco` (
  `idFormacaoPreco` smallint(6) NOT NULL AUTO_INCREMENT,
  `dsFormacaoPreco` varchar(100) DEFAULT NULL,
  `pFrete` float DEFAULT NULL,
  `pIPI` float DEFAULT NULL,
  `pOutrasDespesas` float DEFAULT NULL,
  `pICMSEntrada` float DEFAULT NULL,
  `pICMSSaida` float DEFAULT NULL,
  `pCustoOperacional` float DEFAULT NULL,
  `pOutrosImpostos` float DEFAULT NULL,
  `pComissao` float DEFAULT NULL,
  `pLucro` float DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idFormacaoPreco`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbformapagto
CREATE TABLE IF NOT EXISTS `tbformapagto` (
  `cdFormaPagto` smallint(6) NOT NULL AUTO_INCREMENT,
  `dsFormaPagto` varchar(40) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`cdFormaPagto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbgrupo
CREATE TABLE IF NOT EXISTS `tbgrupo` (
  `idGrupo` int(11) NOT NULL AUTO_INCREMENT,
  `dsGrupo` varchar(40) NOT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idGrupo`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbgrupomedicamento
CREATE TABLE IF NOT EXISTS `tbgrupomedicamento` (
  `idGrupoMedicamento` int(11) NOT NULL AUTO_INCREMENT,
  `idDivisao` int(11) NOT NULL,
  `idSubGrupo` int(11) NOT NULL,
  `idGrupo` int(11) NOT NULL,
  `dsGrupoMedicamento` varchar(50) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idGrupoMedicamento`),
  KEY `fk_tbGrupoMedicamento_tbDivisao` (`idDivisao`),
  CONSTRAINT `fk_tbGrupoMedicamento_tbDivisao` FOREIGN KEY (`idDivisao`) REFERENCES `tbdivisao` (`idDivisao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbgrupousuario
CREATE TABLE IF NOT EXISTS `tbgrupousuario` (
  `idGrupoUsuario` smallint(6) NOT NULL,
  `dsGrupoUsuario` varchar(40) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idGrupoUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbinutilizacaonumeracao
CREATE TABLE IF NOT EXISTS `tbinutilizacaonumeracao` (
  `idInutilizacaoNumeracao` int(11) NOT NULL AUTO_INCREMENT,
  `cnpj` varchar(20) DEFAULT '0',
  `serie` varchar(5) DEFAULT '0',
  `numeroInicial` varchar(50) DEFAULT '0',
  `numeroFinal` varchar(50) DEFAULT '0',
  `justificativa` varchar(50) DEFAULT '0',
  `dtRegistro` varchar(50) DEFAULT '0',
  `usuario` varchar(50) DEFAULT '0',
  PRIMARY KEY (`idInutilizacaoNumeracao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tblistaobjeto
CREATE TABLE IF NOT EXISTS `tblistaobjeto` (
  `idListaObjeto` smallint(6) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `dsListaObjeto` varchar(200) NOT NULL,
  `campo1` varchar(50) DEFAULT NULL,
  `campo2` varchar(50) DEFAULT NULL,
  `campo3` varchar(50) DEFAULT NULL,
  `campo4` varchar(50) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idListaObjeto`),
  KEY `fk_tbListaObjeto_tbLoja` (`idLoja`),
  CONSTRAINT `fk_tbListaObjeto_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tblistaservico
CREATE TABLE IF NOT EXISTS `tblistaservico` (
  `idListaServico` smallint(6) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `dsListaServico` varchar(100) NOT NULL,
  `cdListaServico` int(11) DEFAULT NULL,
  `preco` float DEFAULT NULL,
  `idUnidade` int(11) NOT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idListaServico`),
  KEY `fk_tbListaServico_tbUnidade` (`idUnidade`),
  KEY `fk_tbListaServico_tbLoja` (`idLoja`),
  CONSTRAINT `fk_tbListaServico_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbListaServico_tbUnidade` FOREIGN KEY (`idUnidade`) REFERENCES `tbunidade` (`idUnidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tblistatarefa
CREATE TABLE IF NOT EXISTS `tblistatarefa` (
  `idListaTarefa` smallint(6) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `dsListaTarefa` varchar(100) NOT NULL,
  `preco` float DEFAULT NULL,
  `idUnidade` int(11) NOT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idListaTarefa`),
  KEY `fk_tbListaTarefa_tbUnidade` (`idUnidade`),
  KEY `fk_tbListaTarefa_tbLoja` (`idLoja`),
  CONSTRAINT `fk_tbListaTarefa_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbListaTarefa_tbUnidade` FOREIGN KEY (`idUnidade`) REFERENCES `tbunidade` (`idUnidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tblogusuario
CREATE TABLE IF NOT EXISTS `tblogusuario` (
  `idLodUsuario` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idLoja` int(10) unsigned NOT NULL DEFAULT '0',
  `usuario` varchar(150) NOT NULL,
  `dtAcesso` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dtSaida` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`idLodUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbloja
CREATE TABLE IF NOT EXISTS `tbloja` (
  `idLoja` int(11) NOT NULL AUTO_INCREMENT,
  `apelido` varchar(60) NOT NULL,
  `razaoSocial` varchar(60) DEFAULT NULL,
  `cnpj` varchar(18) NOT NULL,
  `inscEstadual` varchar(15) DEFAULT NULL,
  `inscMunicipal` varchar(15) DEFAULT NULL,
  `cnae` varchar(8) DEFAULT NULL,
  `inscEstadualSTrib` varchar(15) DEFAULT NULL,
  `crt` varchar(1) DEFAULT NULL,
  `idCidade` smallint(6) DEFAULT NULL,
  `endereco` varchar(40) DEFAULT NULL,
  `cmpEndereco` varchar(20) DEFAULT NULL,
  `cep` varchar(10) DEFAULT NULL,
  `bairro` varchar(40) DEFAULT NULL,
  `cidade` varchar(40) DEFAULT NULL,
  `estado` varchar(2) DEFAULT NULL,
  `nroTelefone` varchar(15) DEFAULT NULL,
  `nroFax` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `site` varchar(60) DEFAULT NULL,
  `pessoaResponsavel` varchar(60) DEFAULT NULL,
  `cpfResponsavel` varchar(14) DEFAULT NULL,
  `observacao` varchar(100) DEFAULT NULL,
  `logotipo` varchar(100) DEFAULT NULL,
  `idCrt` int(11) DEFAULT '0',
  `idCnae` int(11) DEFAULT '0',
  `nro` varchar(6) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idLoja`),
  KEY `fk_tbLoja_tbCidade` (`idCidade`),
  CONSTRAINT `fk_tbLoja_tbCidade` FOREIGN KEY (`idCidade`) REFERENCES `tbcidade` (`idCidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbmedicamento
CREATE TABLE IF NOT EXISTS `tbmedicamento` (
  `idMedicamento` int(11) NOT NULL AUTO_INCREMENT,
  `idGrupoMedicamento` int(11) NOT NULL,
  `nmMedicamento` varchar(50) NOT NULL,
  `principioAtivo` varchar(100) DEFAULT NULL,
  `apresentacao` varchar(100) DEFAULT NULL,
  `dosePAtivo` varchar(100) DEFAULT NULL,
  `doseApresentacao` varchar(100) DEFAULT NULL,
  `uso` varchar(100) DEFAULT NULL,
  `indicacao` varchar(100) DEFAULT NULL,
  `fabricante` varchar(50) DEFAULT NULL,
  `observacao` varchar(100) DEFAULT NULL,
  `idProduto` int(11) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idMedicamento`),
  KEY `fk_tbMedicamento_tbGrupoMedicamento` (`idGrupoMedicamento`),
  KEY `fk_tbMedicamento_tbProduto` (`idProduto`),
  CONSTRAINT `fk_tbMedicamento_tbGrupoMedicamento` FOREIGN KEY (`idGrupoMedicamento`) REFERENCES `tbgrupomedicamento` (`idGrupoMedicamento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbMedicamento_tbProduto` FOREIGN KEY (`idProduto`) REFERENCES `tbproduto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbmesa
CREATE TABLE IF NOT EXISTS `tbmesa` (
  `idMesa` int(11) NOT NULL AUTO_INCREMENT,
  `dsMesa` varchar(30) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idMesa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbncm
CREATE TABLE IF NOT EXISTS `tbncm` (
  `cdNcm` varchar(10) NOT NULL,
  `dsNcm` varchar(200) NOT NULL,
  PRIMARY KEY (`cdNcm`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbnfe
CREATE TABLE IF NOT EXISTS `tbnfe` (
  `idNfe` int(11) NOT NULL AUTO_INCREMENT,
  `idPedidoSaida` bigint(20) DEFAULT NULL,
  `cuf` varchar(45) DEFAULT NULL,
  `cnf` varchar(45) DEFAULT NULL,
  `natop` varchar(45) DEFAULT NULL,
  `indpag` varchar(45) DEFAULT NULL,
  `modi` varchar(45) DEFAULT NULL,
  `serie` varchar(45) DEFAULT NULL,
  `nnf` int(11) DEFAULT NULL,
  `demi` varchar(45) DEFAULT NULL,
  `dsaient` varchar(45) DEFAULT NULL,
  `tpnf` varchar(45) DEFAULT NULL,
  `cmunfg` varchar(45) DEFAULT NULL,
  `tpimp` varchar(45) DEFAULT NULL,
  `tpemis` varchar(45) DEFAULT NULL,
  `tpamb` varchar(45) DEFAULT NULL,
  `finnfe` varchar(45) DEFAULT NULL,
  `procemi` varchar(45) DEFAULT NULL,
  `emit_cnpj` varchar(45) DEFAULT NULL,
  `emit_xnome` varchar(300) DEFAULT NULL,
  `emit_xfant` varchar(300) DEFAULT NULL,
  `emit_xlgr` varchar(300) DEFAULT NULL,
  `emit_nro` varchar(45) DEFAULT NULL,
  `emit_xcpl` varchar(300) DEFAULT NULL,
  `emit_xbairro` varchar(300) DEFAULT NULL,
  `emit_cmun` varchar(45) DEFAULT NULL,
  `emit_xmun` varchar(250) DEFAULT NULL,
  `emit_uf` varchar(45) DEFAULT NULL,
  `emit_cep` varchar(45) DEFAULT NULL,
  `emit_fone` varchar(45) DEFAULT NULL,
  `emit_ie` varchar(45) DEFAULT NULL,
  `emit_iest` varchar(45) DEFAULT NULL,
  `emit_im` varchar(45) DEFAULT NULL,
  `emit_cnae` varchar(45) DEFAULT NULL,
  `dest_cnpj` varchar(45) DEFAULT NULL,
  `dest_cpf` varchar(45) DEFAULT NULL,
  `dest_xnome` varchar(600) DEFAULT NULL,
  `dest_xlgr` varchar(45) DEFAULT NULL,
  `dest_nro` varchar(45) DEFAULT NULL,
  `dest_xcpl` varchar(250) DEFAULT NULL,
  `dest_xbairro` varchar(250) DEFAULT NULL,
  `dest_cmun` varchar(45) DEFAULT NULL,
  `dest_xmun` varchar(300) DEFAULT NULL,
  `dest_uf` varchar(45) DEFAULT NULL,
  `dest_cep` varchar(45) DEFAULT NULL,
  `dest_fone` varchar(45) DEFAULT NULL,
  `dest_ie` varchar(45) DEFAULT NULL,
  `dest_isuf` varchar(45) DEFAULT NULL,
  `retirada_cnpj` varchar(45) DEFAULT NULL,
  `retirada_xlgr` varchar(45) DEFAULT NULL,
  `retirada_nro` varchar(45) DEFAULT NULL,
  `retirada_xcpl` varchar(45) DEFAULT NULL,
  `retirada_xbairro` varchar(45) DEFAULT NULL,
  `retirada_cmun` varchar(45) DEFAULT NULL,
  `retirada_xmun` varchar(45) DEFAULT NULL,
  `entrega_cnpj` varchar(45) DEFAULT NULL,
  `entrega_xlgr` varchar(45) DEFAULT NULL,
  `entrega_nro` varchar(45) DEFAULT NULL,
  `entrega_xcpl` varchar(45) DEFAULT NULL,
  `entrega_xbairro` varchar(45) DEFAULT NULL,
  `entrega_cmun` varchar(45) DEFAULT NULL,
  `entrega_xmun` varchar(45) DEFAULT NULL,
  `icmstot_vbc` varchar(45) DEFAULT NULL,
  `icmstot_vicms` varchar(45) DEFAULT NULL,
  `icmstot_vbcst` varchar(45) DEFAULT NULL,
  `icmstot_vst` varchar(45) DEFAULT NULL,
  `icmstot_vprod` varchar(45) DEFAULT NULL,
  `icmstot_vfrete` varchar(45) DEFAULT NULL,
  `icmstot_vseg` varchar(45) DEFAULT NULL,
  `icmstot_vdesc` varchar(45) DEFAULT NULL,
  `icmstot_vii` varchar(45) DEFAULT NULL,
  `icmstot_vipi` varchar(45) DEFAULT NULL,
  `icmstot_vpis` varchar(45) DEFAULT NULL,
  `icmstot_vcofins` varchar(45) DEFAULT NULL,
  `icmstot_voutro` varchar(45) DEFAULT NULL,
  `icmstot_vnf` varchar(45) DEFAULT NULL,
  `rettrib_vretpis` varchar(45) DEFAULT NULL,
  `rettrib_vretcofins` varchar(45) DEFAULT NULL,
  `rettrib_vretcsll` varchar(45) DEFAULT NULL,
  `rettrib_vbcirrf` varchar(45) DEFAULT NULL,
  `rettrib_virrf` varchar(45) DEFAULT NULL,
  `rettrib_vbcretprev` varchar(45) DEFAULT NULL,
  `rettrib_vretprev` varchar(45) DEFAULT NULL,
  `transp_modfrete` varchar(45) DEFAULT NULL,
  `transp_cnpj` varchar(45) DEFAULT NULL,
  `transp_cpf` varchar(45) DEFAULT NULL,
  `transp_xnome` varchar(45) DEFAULT NULL,
  `transp_ie` varchar(45) DEFAULT NULL,
  `transp_xender` varchar(45) DEFAULT NULL,
  `transp_xmun` varchar(45) DEFAULT NULL,
  `transp_uf` varchar(45) DEFAULT NULL,
  `transp_vserv` varchar(45) DEFAULT NULL,
  `transp_vbcret` varchar(45) DEFAULT NULL,
  `transp_picmsret` varchar(45) DEFAULT NULL,
  `transp_vicmsret` varchar(45) DEFAULT NULL,
  `transp_cfop` varchar(45) DEFAULT NULL,
  `transp_cmunfg` varchar(45) DEFAULT NULL,
  `transp_placa` varchar(45) DEFAULT NULL,
  `transp_uf_placa` varchar(45) DEFAULT NULL,
  `transp_rntc` varchar(45) DEFAULT NULL,
  `cobr_nfat` varchar(45) DEFAULT NULL,
  `cobr_vorig` varchar(45) DEFAULT NULL,
  `cobr_vdesc` varchar(45) DEFAULT NULL,
  `cobr_vliq` varchar(45) DEFAULT NULL,
  `compra_xnemp` varchar(45) DEFAULT NULL,
  `compra_xped` varchar(45) DEFAULT NULL,
  `compra_xcont` varchar(45) DEFAULT NULL,
  `chnfe` varchar(45) DEFAULT NULL,
  `nprot` varchar(45) DEFAULT NULL,
  `id_empresa` varchar(45) DEFAULT NULL,
  `cstat` varchar(45) DEFAULT NULL,
  `tbnfecol` varchar(45) DEFAULT NULL,
  `xmotivo` varchar(600) DEFAULT NULL,
  `dtprot` varchar(45) DEFAULT NULL,
  `in_status` varchar(45) DEFAULT NULL,
  `cd_barras_contigencia` varchar(45) DEFAULT NULL,
  `id_contingencia` varchar(45) DEFAULT NULL,
  `nm_usuario` varchar(45) DEFAULT NULL,
  `dt_registro` varchar(45) DEFAULT NULL,
  `emit_crt` varchar(45) DEFAULT NULL,
  `dhcont` varchar(45) DEFAULT NULL,
  `xjust` varchar(600) DEFAULT NULL,
  `dest_email` varchar(45) DEFAULT NULL,
  `retirada_cpf` varchar(45) DEFAULT NULL,
  `entrega_cpf` varchar(45) DEFAULT NULL,
  `dest_cpais` varchar(45) DEFAULT NULL,
  `dest_xpais` varchar(45) DEFAULT NULL,
  `transp_qvol` varchar(45) DEFAULT NULL,
  `transp_pesol` varchar(45) DEFAULT NULL,
  `transp_pesob` varchar(45) DEFAULT NULL,
  `dt_envio_email` varchar(45) DEFAULT NULL,
  `email_enviado` varchar(45) DEFAULT NULL,
  `ufembarq` varchar(45) DEFAULT NULL,
  `xlocembarq` varchar(45) DEFAULT NULL,
  `dest_iddest` varchar(45) DEFAULT NULL,
  `indfinal` varchar(45) DEFAULT NULL,
  `indpres` varchar(45) DEFAULT NULL,
  `dt_inicio_transacao` varchar(45) DEFAULT NULL,
  `dt_termino_transacao` varchar(45) DEFAULT NULL,
  `nr_pedido` varchar(45) DEFAULT NULL,
  `nr_os` varchar(45) DEFAULT NULL,
  `id_entidade_vendedor` varchar(45) DEFAULT NULL,
  `digval` varchar(45) DEFAULT NULL,
  `icmstot_vtottrib` varchar(45) DEFAULT NULL,
  `nr_tempo_gasto_solicitacao` varchar(45) DEFAULT NULL,
  `verproc` varchar(45) DEFAULT NULL,
  `ds_xml` longblob,
  `link_portal_nfc` varchar(250) DEFAULT NULL,
  `link_qrcode_nfc` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`idNfe`),
  KEY `consultaNNF` (`nnf`)
) ENGINE=InnoDB AUTO_INCREMENT=55022 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbnfecancelamento
CREATE TABLE IF NOT EXISTS `tbnfecancelamento` (
  `idnfecancelamento` int(11) NOT NULL AUTO_INCREMENT,
  `id_empresa` varchar(3) DEFAULT NULL,
  `chnfe` varchar(45) DEFAULT NULL,
  `xjust` varchar(250) DEFAULT NULL,
  `tpamb` varchar(3) DEFAULT NULL,
  `veraplic` varchar(45) DEFAULT NULL,
  `cstat` varchar(45) DEFAULT NULL,
  `xmotivo` varchar(600) DEFAULT NULL,
  `cuf` varchar(45) DEFAULT NULL,
  `nprotcanc` varchar(45) DEFAULT NULL,
  `dhrecbto` varchar(45) DEFAULT NULL,
  `nm_usuario` varchar(45) DEFAULT NULL,
  `dt_registro` varchar(45) DEFAULT NULL,
  `id` varchar(600) DEFAULT NULL,
  `dhrevento` varchar(45) DEFAULT NULL,
  `tpevento` varchar(45) DEFAULT NULL,
  `nseqevento` varchar(300) DEFAULT NULL,
  `descevento` varchar(300) DEFAULT NULL,
  `nprot` varchar(45) DEFAULT NULL,
  `ds_xml` blob,
  `ds_xml_recebido` blob,
  `idNfe` int(11) DEFAULT NULL,
  PRIMARY KEY (`idnfecancelamento`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbnfeformapagamento
CREATE TABLE IF NOT EXISTS `tbnfeformapagamento` (
  `idFormaPagamento` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idNfe` int(11) DEFAULT NULL,
  `tpag` varchar(45) DEFAULT NULL,
  `vpag` varchar(45) DEFAULT NULL,
  `cnpj` varchar(45) DEFAULT NULL,
  `tband` varchar(45) DEFAULT NULL,
  `caut` varchar(45) DEFAULT NULL,
  `dt_registro` varchar(45) DEFAULT NULL,
  `ds_descricao_comercial_midas` varchar(45) DEFAULT NULL,
  `nr_banco` varchar(45) DEFAULT NULL,
  `nr_cheque` varchar(45) DEFAULT NULL,
  `nr_conta` varchar(45) DEFAULT NULL,
  `nr_agencia` varchar(45) DEFAULT NULL,
  `id_modalidade_pagamento` varchar(45) DEFAULT NULL,
  `dt_vencimento` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idFormaPagamento`)
) ENGINE=InnoDB AUTO_INCREMENT=55508 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbnfelancamento
CREATE TABLE IF NOT EXISTS `tbnfelancamento` (
  `idLancamento` int(11) NOT NULL AUTO_INCREMENT,
  `idNfe` int(11) DEFAULT NULL,
  `dt_registro` varchar(45) DEFAULT NULL,
  `id_modalidade_pagamento` varchar(45) DEFAULT NULL,
  `ds_modalidade_pagamento` varchar(45) DEFAULT NULL,
  `valor` varchar(45) DEFAULT NULL,
  `dt_vencimento` varchar(45) DEFAULT NULL,
  `caut` varchar(45) DEFAULT NULL,
  `nr_banco` varchar(45) DEFAULT NULL,
  `nr_cheque` varchar(45) DEFAULT NULL,
  `nr_conta` varchar(45) DEFAULT NULL,
  `nr_agencia` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idLancamento`)
) ENGINE=InnoDB AUTO_INCREMENT=50347 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbnfelote
CREATE TABLE IF NOT EXISTS `tbnfelote` (
  `idLote` int(11) NOT NULL AUTO_INCREMENT,
  `idNfe` int(11) DEFAULT NULL,
  `tpamb` varchar(45) DEFAULT NULL,
  `veraplic` varchar(45) DEFAULT NULL,
  `cstat` varchar(45) DEFAULT NULL,
  `xmotivo` varchar(600) DEFAULT NULL,
  `cuf` varchar(45) DEFAULT NULL,
  `nrec` varchar(45) DEFAULT NULL,
  `dhrecbto` varchar(45) DEFAULT NULL,
  `tmed` varchar(45) DEFAULT NULL,
  `in_status` varchar(45) DEFAULT NULL,
  `nm_usuario` varchar(200) DEFAULT NULL,
  `dt_registro` varchar(45) DEFAULT NULL,
  `ds_xml` blob,
  `ds_xml_recebido` blob,
  PRIMARY KEY (`idLote`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbnfeproduto
CREATE TABLE IF NOT EXISTS `tbnfeproduto` (
  `idNfeProduto` int(11) NOT NULL AUTO_INCREMENT,
  `idNfe` int(11) DEFAULT NULL,
  `tp_registro` varchar(45) DEFAULT NULL,
  `tp_produto_especifico` varchar(45) DEFAULT NULL,
  `nitem` varchar(45) DEFAULT NULL,
  `cprod` varchar(45) DEFAULT NULL,
  `cean` varchar(45) DEFAULT NULL,
  `xprod` varchar(200) DEFAULT NULL,
  `ncm` varchar(45) DEFAULT NULL,
  `extipi` varchar(45) DEFAULT NULL,
  `genero` varchar(45) DEFAULT NULL,
  `cfop` varchar(45) DEFAULT NULL,
  `ucom` varchar(45) DEFAULT NULL,
  `qcom` varchar(45) DEFAULT NULL,
  `vuncom` varchar(45) DEFAULT NULL,
  `vprod` varchar(45) DEFAULT NULL,
  `utrib` varchar(45) DEFAULT NULL,
  `qtrib` varchar(45) DEFAULT NULL,
  `vuntrib` varchar(45) DEFAULT NULL,
  `vfrete` varchar(45) DEFAULT NULL,
  `vseg` varchar(45) DEFAULT NULL,
  `vdesc` varchar(45) DEFAULT NULL,
  `imposto_orig` varchar(45) DEFAULT NULL,
  `imposto_cst` varchar(45) DEFAULT NULL,
  `imposto_modbc` varchar(45) DEFAULT NULL,
  `imposto_predbc` varchar(45) DEFAULT NULL,
  `imposto_vbc` varchar(45) DEFAULT NULL,
  `imposto_picms` varchar(45) DEFAULT NULL,
  `imposto_vicms` varchar(45) DEFAULT NULL,
  `imposto_modbcst` varchar(45) DEFAULT NULL,
  `imposto_pmvast` varchar(45) DEFAULT NULL,
  `imposto_predbcst` varchar(45) DEFAULT NULL,
  `imposto_vbcst` varchar(45) DEFAULT NULL,
  `imposto_picmsst` varchar(45) DEFAULT NULL,
  `imposto_vicmsst` varchar(45) DEFAULT NULL,
  `importacao_vbc` varchar(45) DEFAULT NULL,
  `importacao_vdespadu` varchar(45) DEFAULT NULL,
  `importacao_vii` varchar(45) DEFAULT NULL,
  `importacao_viof` varchar(45) DEFAULT NULL,
  `pis_cst` varchar(45) DEFAULT NULL,
  `pis_vbc` varchar(45) DEFAULT NULL,
  `pis_ppis` varchar(45) DEFAULT NULL,
  `pis_qbcprod` varchar(45) DEFAULT NULL,
  `pis_valiqprod` varchar(45) DEFAULT NULL,
  `pis_vpis` varchar(45) DEFAULT NULL,
  `pisst_vbc` varchar(45) DEFAULT NULL,
  `pisst_ppis` varchar(45) DEFAULT NULL,
  `pisst_qbcprod` varchar(45) DEFAULT NULL,
  `pisst_valiqprod` varchar(45) DEFAULT NULL,
  `pisst_vpis` varchar(45) DEFAULT NULL,
  `cofins_cst` varchar(45) DEFAULT NULL,
  `cofins_vbc` varchar(45) DEFAULT NULL,
  `cofins_pcofins` varchar(45) DEFAULT NULL,
  `cofins_qbcprod` varchar(45) DEFAULT NULL,
  `cofins_valiqprod` varchar(45) DEFAULT NULL,
  `cofins_vcofins` varchar(45) DEFAULT NULL,
  `cofinsst_vbc` varchar(45) DEFAULT NULL,
  `cofinsst_pcofins` varchar(45) DEFAULT NULL,
  `cofinsst_qbcprod` varchar(45) DEFAULT NULL,
  `cofinsst_valiqprod` varchar(45) DEFAULT NULL,
  `cofinsst_vcofins` varchar(45) DEFAULT NULL,
  `ipi_cenq` varchar(45) DEFAULT NULL,
  `ipi_cst` varchar(45) DEFAULT NULL,
  `ipi_vbc` varchar(45) DEFAULT NULL,
  `ipi_qunid` varchar(45) DEFAULT NULL,
  `ipi_vunid` varchar(45) DEFAULT NULL,
  `ipi_pipi` varchar(45) DEFAULT NULL,
  `ipi_vipi` varchar(45) DEFAULT NULL,
  `voutro` varchar(45) DEFAULT NULL,
  `indtot` varchar(45) DEFAULT NULL,
  `imposto_motdesicms` varchar(45) DEFAULT NULL,
  `imposto_pcredsn` varchar(45) DEFAULT NULL,
  `imposto_vcredicmssn` varchar(45) DEFAULT NULL,
  `cprod_alternativo` varchar(45) DEFAULT NULL,
  `ii_vbc` varchar(45) DEFAULT NULL,
  `ii_vdespadu` varchar(45) DEFAULT NULL,
  `ii_vii` varchar(45) DEFAULT NULL,
  `ii_viof` varchar(45) DEFAULT NULL,
  `vtottrib` varchar(45) DEFAULT NULL,
  `nfci` varchar(45) DEFAULT NULL,
  `tbnfeprodutocol` varchar(45) DEFAULT NULL,
  `idPedidoSaida` int(11) DEFAULT NULL,
  `status` varchar(2) DEFAULT 'A',
  `serie` int(11) DEFAULT NULL,
  PRIMARY KEY (`idNfeProduto`),
  KEY `ConsultaSerie` (`serie`)
) ENGINE=InnoDB AUTO_INCREMENT=207989 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tborcamento
CREATE TABLE IF NOT EXISTS `tborcamento` (
  `idOrcamento` bigint(20) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `cdEntidade` int(11) DEFAULT NULL,
  `idEntrega` int(11) DEFAULT NULL,
  `idColaborador` int(11) NOT NULL,
  `dtOrc` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtEntrega` timestamp NULL DEFAULT NULL,
  `hrEntrega` varchar(5) DEFAULT NULL,
  `pessoaResponsavel` varchar(60) DEFAULT NULL,
  `vlOrc` double DEFAULT NULL,
  `prazoValidade` smallint(6) DEFAULT NULL,
  `vlDesc` float DEFAULT NULL,
  `observacao` varchar(200) DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `vlAprov` double DEFAULT NULL,
  `dtAprov` timestamp NULL DEFAULT NULL,
  `idOrdemServico` bigint(20) DEFAULT NULL,
  `cdCondPagto` int(11) DEFAULT NULL,
  `prazoEntrega` smallint(6) DEFAULT NULL,
  `prazoGarantia` smallint(6) DEFAULT NULL COMMENT '	',
  `cmpOc1` varchar(50) DEFAULT NULL,
  `cmpOc2` varchar(50) DEFAULT NULL,
  `cmpOc3` varchar(50) DEFAULT NULL,
  `cmpOc4` varchar(50) DEFAULT NULL,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idOrcamento`),
  KEY `fk_tbOrcamento_tbLoja` (`idLoja`),
  KEY `fk_tbOrcamento_tbColaborador` (`idColaborador`),
  KEY `fk_tbOrcamento_tbEntrega` (`idEntrega`),
  KEY `fk_tbOrcamento_tbEntidade` (`cdEntidade`),
  KEY `fk_tbOrcamento_tbOrdemServico` (`idOrdemServico`),
  KEY `fk_tbOrcamento_tbCondPagto` (`cdCondPagto`),
  CONSTRAINT `fk_tbOrcamento_tbColaborador` FOREIGN KEY (`idColaborador`) REFERENCES `tbcolaborador` (`idColaborador`),
  CONSTRAINT `fk_tbOrcamento_tbCondPagto` FOREIGN KEY (`cdCondPagto`) REFERENCES `tbcondpagto` (`cdCondPagto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrcamento_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrcamento_tbEntrega` FOREIGN KEY (`idEntrega`) REFERENCES `tbentrega` (`idEntrega`),
  CONSTRAINT `fk_tbOrcamento_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`),
  CONSTRAINT `fk_tbOrcamento_tbOrdemServico` FOREIGN KEY (`idOrdemServico`) REFERENCES `tbordemservico` (`idOrdemServico`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9922 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tborcamentoempresa
CREATE TABLE IF NOT EXISTS `tborcamentoempresa` (
  `idOrcamentoEmpresa` smallint(6) NOT NULL AUTO_INCREMENT,
  `nmOrcamentoEmpresa` varchar(50) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idOrcamentoEmpresa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tborcamentoempresaitem
CREATE TABLE IF NOT EXISTS `tborcamentoempresaitem` (
  `idOrcamentoEmpresaItem` int(11) NOT NULL AUTO_INCREMENT,
  `idOrcamentoEmpresa` smallint(6) NOT NULL,
  `idPlanoConta` smallint(6) NOT NULL,
  `dtComp` date DEFAULT NULL,
  `valor` double NOT NULL,
  `dtMov` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idOrcamentoEmpresaItem`),
  KEY `fk_tbOrcamentoEmpresaItem_tbOrcamentoEmpresa` (`idOrcamentoEmpresa`),
  KEY `fk_tbOrcamentoEmpresaItem_tbPlanoConta` (`idPlanoConta`),
  CONSTRAINT `fk_tbOrcamentoEmpresaItem_tbOrcamentoEmpresa` FOREIGN KEY (`idOrcamentoEmpresa`) REFERENCES `tborcamentoempresa` (`idOrcamentoEmpresa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrcamentoEmpresaItem_tbPlanoConta` FOREIGN KEY (`idPlanoConta`) REFERENCES `tbplanoconta` (`idPlanoConta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tborcamentoitem
CREATE TABLE IF NOT EXISTS `tborcamentoitem` (
  `idOrcamentoItem` bigint(20) NOT NULL AUTO_INCREMENT,
  `idOrcamento` bigint(20) NOT NULL,
  `idProduto` int(11) NOT NULL,
  `tbUnidade_idUnidade` int(11) DEFAULT NULL,
  `idAgrupamento` smallint(6) DEFAULT NULL,
  `dsCompProduto` varchar(100) DEFAULT NULL,
  `comp` float DEFAULT NULL,
  `larg` float DEFAULT NULL,
  `quant` float DEFAULT NULL,
  `valor` float DEFAULT NULL,
  `pDesc` float DEFAULT NULL,
  `vlUni` float DEFAULT NULL,
  `aprovado` varchar(1) NOT NULL,
  `valorAprov` float DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idOrcamentoItem`),
  KEY `fk_tbOrcamentoItem_tbProduto` (`idProduto`),
  KEY `fk_tbOrcamentoItem_tbOrcamento` (`idOrcamento`),
  KEY `fk_tbOrcamentoItem_tbUnidade` (`tbUnidade_idUnidade`),
  KEY `fk_tbOrcamentoItem_tbAgrupamento` (`idAgrupamento`),
  CONSTRAINT `fk_tbOrcamentoItem_tbAgrupamento` FOREIGN KEY (`idAgrupamento`) REFERENCES `tbagrupamento` (`idAgrupamento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrcamentoItem_tbOrcamento` FOREIGN KEY (`idOrcamento`) REFERENCES `tborcamento` (`idOrcamento`),
  CONSTRAINT `fk_tbOrcamentoItem_tbProduto` FOREIGN KEY (`idProduto`) REFERENCES `tbproduto` (`idProduto`),
  CONSTRAINT `fk_tbOrcamentoItem_tbUnidade` FOREIGN KEY (`tbUnidade_idUnidade`) REFERENCES `tbunidade` (`idUnidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=96195 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tborcamentopedidosaida
CREATE TABLE IF NOT EXISTS `tborcamentopedidosaida` (
  `idOrcamento` bigint(20) NOT NULL,
  `idPedidoSaida` bigint(20) NOT NULL,
  PRIMARY KEY (`idPedidoSaida`,`idOrcamento`),
  KEY `fk_tbOrcamentoPedidoSaida_tbPedidoSaida` (`idPedidoSaida`),
  KEY `fk_tbtbOrcamentoPedidoSaida_tbOrcamento` (`idOrcamento`),
  CONSTRAINT `fk_tbOrcamentoPedidoSaida_tbPedidoSaida` FOREIGN KEY (`idPedidoSaida`) REFERENCES `tbpedidosaida` (`idPedidoSaida`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbtbOrcamentoPedidoSaida_tbOrcamento` FOREIGN KEY (`idOrcamento`) REFERENCES `tborcamento` (`idOrcamento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tborcamentosubitem
CREATE TABLE IF NOT EXISTS `tborcamentosubitem` (
  `idOrcamentoSubItem` bigint(20) NOT NULL AUTO_INCREMENT,
  `idOrcamentoItem` bigint(20) NOT NULL,
  `idProduto` int(11) NOT NULL,
  `idUnidade` int(11) DEFAULT NULL,
  `comp` float DEFAULT NULL,
  `larg` float DEFAULT NULL,
  `quant` float DEFAULT NULL,
  `pDesc` float DEFAULT NULL,
  `vlUni` float DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idOrcamentoSubItem`),
  KEY `fk_tbOrcamentoSubItem_tbOrcamentoItem` (`idOrcamentoItem`),
  KEY `fk_tbOrcamentoSubItem_tbProduto` (`idProduto`),
  KEY `fk_tbOrcamentoSubItem_tbUnidade` (`idUnidade`),
  CONSTRAINT `fk_tbOrcamentoSubItem_tbOrcamentoItem` FOREIGN KEY (`idOrcamentoItem`) REFERENCES `tborcamentoitem` (`idOrcamentoItem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrcamentoSubItem_tbProduto` FOREIGN KEY (`idProduto`) REFERENCES `tbproduto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrcamentoSubItem_tbUnidade` FOREIGN KEY (`idUnidade`) REFERENCES `tbunidade` (`idUnidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbordemproducao
CREATE TABLE IF NOT EXISTS `tbordemproducao` (
  `idOrdemProducao` bigint(20) NOT NULL,
  `idProduto` int(11) NOT NULL,
  `idUnidade` int(11) NOT NULL,
  `idColaborador` int(11) DEFAULT NULL,
  `dtOrd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtEntrega` timestamp NULL DEFAULT NULL,
  `dtInicio` timestamp NULL DEFAULT NULL,
  `dtConclusao` timestamp NULL DEFAULT NULL,
  `quant` float DEFAULT NULL,
  `quatProduzida` float DEFAULT NULL,
  `observacao` varchar(200) DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `idPedidoSaida` bigint(20) DEFAULT NULL,
  `idPedidoEntrada` bigint(20) DEFAULT NULL,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idOrdemProducao`),
  KEY `fk_tbOrdemProducao_tbProduto` (`idProduto`),
  KEY `fk_tbOrdemProducao_tbUnidade` (`idUnidade`),
  KEY `fk_tbOrdemProducao_tbPedidoSaida` (`idPedidoSaida`),
  KEY `fk_tbOrdemProducao_tbPedidoEntrada` (`idPedidoEntrada`),
  KEY `fk_tbOrdemProducao_tbColaborador` (`idColaborador`),
  CONSTRAINT `fk_tbOrdemProducao_tbColaborador` FOREIGN KEY (`idColaborador`) REFERENCES `tbcolaborador` (`idColaborador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemProducao_tbPedidoEntrada` FOREIGN KEY (`idPedidoEntrada`) REFERENCES `tbpedidoentrada` (`idPedidoEntrada`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemProducao_tbPedidoSaida` FOREIGN KEY (`idPedidoSaida`) REFERENCES `tbpedidosaida` (`idPedidoSaida`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemProducao_tbProduto` FOREIGN KEY (`idProduto`) REFERENCES `tbproduto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemProducao_tbUnidade` FOREIGN KEY (`idUnidade`) REFERENCES `tbunidade` (`idUnidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbordemproducaoitem
CREATE TABLE IF NOT EXISTS `tbordemproducaoitem` (
  `idOrdemProducaoItem` bigint(20) NOT NULL AUTO_INCREMENT,
  `idOrdemProducao` bigint(20) NOT NULL,
  `idProduto` int(11) NOT NULL,
  `idUnidade` int(11) NOT NULL,
  `composicao` float DEFAULT NULL,
  `fixo` varchar(1) DEFAULT NULL,
  `requerido` float DEFAULT NULL,
  `perda` float DEFAULT NULL,
  `utilizada` float DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idOrdemProducaoItem`),
  KEY `fk_tbOrdemProducaoItem_tbOrdemProducao` (`idOrdemProducao`),
  KEY `fk_tbOrdemProducaoItem_tbProduto` (`idProduto`),
  KEY `fk_tbOrdemProducaoItem_tbUnidade` (`idUnidade`),
  CONSTRAINT `fk_tbOrdemProducaoItem_tbOrdemProducao` FOREIGN KEY (`idOrdemProducao`) REFERENCES `tbordemproducao` (`idOrdemProducao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemProducaoItem_tbProduto` FOREIGN KEY (`idProduto`) REFERENCES `tbproduto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemProducaoItem_tbUnidade` FOREIGN KEY (`idUnidade`) REFERENCES `tbunidade` (`idUnidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbordemservico
CREATE TABLE IF NOT EXISTS `tbordemservico` (
  `idOrdemServico` bigint(20) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `cdEntidade` int(11) DEFAULT NULL,
  `idColaborador` int(11) NOT NULL,
  `idEntrega` int(11) DEFAULT NULL,
  `cdTipoAtendimento` int(11) NOT NULL,
  `tipo` varchar(1) DEFAULT NULL,
  `dtOrc` timestamp NULL DEFAULT NULL,
  `dtOS` timestamp NULL DEFAULT NULL,
  `dtAprov` timestamp NULL DEFAULT NULL,
  `dtEntrega` timestamp NULL DEFAULT NULL,
  `pessoaResponsavel` varchar(60) DEFAULT NULL,
  `dtInicio` timestamp NULL DEFAULT NULL,
  `dtConclusao` timestamp NULL DEFAULT NULL,
  `dtEntRealizada` timestamp NULL DEFAULT NULL,
  `cdCondPagto` int(11) DEFAULT NULL,
  `prazoEntrega` smallint(6) DEFAULT NULL,
  `prazoValidade` smallint(6) DEFAULT NULL,
  `prazoGarantia` smallint(6) DEFAULT NULL,
  `cmpOS1` varchar(50) DEFAULT NULL,
  `cmpOS2` varchar(50) DEFAULT NULL,
  `cmpOS3` varchar(50) DEFAULT NULL,
  `cmpOS4` varchar(50) DEFAULT NULL,
  `observacao` varchar(200) DEFAULT NULL,
  `vlServ` double DEFAULT NULL,
  `vlProd` double DEFAULT NULL,
  `vlFrete` float DEFAULT NULL,
  `vlDesc` float DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idOrdemServico`),
  KEY `fk_tbOrdemServico_tbCondPagto` (`cdCondPagto`),
  KEY `fk_tbOrdemServico_tbColaborador` (`idColaborador`),
  KEY `fk_tbOrdemServico_tbLoja` (`idLoja`),
  KEY `fk_tbOrdemServico_tbEntidade` (`cdEntidade`),
  KEY `fk_tbOrdemServico_tbTipoAtendimento` (`cdTipoAtendimento`),
  KEY `fk_tbOrdemServico_tbEntrega` (`idEntrega`),
  CONSTRAINT `fk_tbOrdemServico_tbColaborador` FOREIGN KEY (`idColaborador`) REFERENCES `tbcolaborador` (`idColaborador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemServico_tbCondPagto` FOREIGN KEY (`cdCondPagto`) REFERENCES `tbcondpagto` (`cdCondPagto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemServico_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemServico_tbEntrega` FOREIGN KEY (`idEntrega`) REFERENCES `tbentrega` (`idEntrega`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemServico_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemServico_tbTipoAtendimento` FOREIGN KEY (`cdTipoAtendimento`) REFERENCES `tbtipoatendimento` (`cdTipoAtendimento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbordemservicoitem
CREATE TABLE IF NOT EXISTS `tbordemservicoitem` (
  `idOrdemServicoItem` bigint(20) NOT NULL AUTO_INCREMENT,
  `idOrdemServicoObjeto` bigint(20) NOT NULL,
  `idListaServico` smallint(6) NOT NULL,
  `dsCompServico` varchar(100) DEFAULT NULL,
  `comp` float DEFAULT NULL,
  `larg` float DEFAULT NULL,
  `quant` float DEFAULT NULL,
  `valor` float DEFAULT NULL,
  `pDesc` float DEFAULT NULL,
  `vlUni` float DEFAULT NULL,
  `idColaborador` int(11) DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idOrdemServicoItem`),
  KEY `fk_tbOrdemServicoItem_tbOrdemServicoObjeto` (`idOrdemServicoObjeto`),
  KEY `fk_tbOrdemServicoItem_tbListaServico` (`idListaServico`),
  KEY `fk_tbOrdemServicoItem_tbColaborador` (`idColaborador`),
  CONSTRAINT `fk_tbOrdemServicoItem_tbColaborador` FOREIGN KEY (`idColaborador`) REFERENCES `tbcolaborador` (`idColaborador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemServicoItem_tbListaServico` FOREIGN KEY (`idListaServico`) REFERENCES `tblistaservico` (`idListaServico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemServicoItem_tbOrdemServicoObjeto` FOREIGN KEY (`idOrdemServicoObjeto`) REFERENCES `tbordemservicoobjeto` (`idOrdemServicoObjeto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbordemservicoobjeto
CREATE TABLE IF NOT EXISTS `tbordemservicoobjeto` (
  `idOrdemServicoObjeto` bigint(20) NOT NULL AUTO_INCREMENT,
  `idOrdemServico` bigint(20) NOT NULL,
  `idListaObjeto` smallint(6) NOT NULL,
  `campo1` varchar(50) DEFAULT NULL,
  `campo2` varchar(50) DEFAULT NULL,
  `campo3` varchar(50) DEFAULT NULL,
  `campo4` varchar(50) DEFAULT NULL,
  `observacao` varchar(100) DEFAULT NULL,
  `dtGarantia` date DEFAULT NULL,
  `nrControle` int(11) DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idOrdemServicoObjeto`),
  KEY `fk_tbOrdemServicoItem_tbOrdemServico` (`idOrdemServico`),
  KEY `fk_tbOrdemServicoItem_tbListaObjeto` (`idListaObjeto`),
  CONSTRAINT `fk_tbOrdemServicoItem_tbListaObjeto` FOREIGN KEY (`idListaObjeto`) REFERENCES `tblistaobjeto` (`idListaObjeto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemServicoItem_tbOrdemServico` FOREIGN KEY (`idOrdemServico`) REFERENCES `tbordemservico` (`idOrdemServico`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbordemservicotarefa
CREATE TABLE IF NOT EXISTS `tbordemservicotarefa` (
  `idOrdemServicoTarefa` bigint(20) NOT NULL AUTO_INCREMENT,
  `idOrdemServicoItem` bigint(20) NOT NULL,
  `idListaTarefa` smallint(6) NOT NULL,
  `dsCompTarefa` varchar(100) DEFAULT NULL,
  `quant` float DEFAULT NULL,
  `valor` float DEFAULT NULL,
  `pDesc` float DEFAULT NULL,
  `vlUni` float DEFAULT NULL,
  `idColaborador` int(11) DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idOrdemServicoTarefa`),
  KEY `fk_tbOrdemServicoTarefa_tbOrdemServicoItem` (`idOrdemServicoItem`),
  KEY `fk_tbOrdemServicoTarefa_tbListaTarefa` (`idListaTarefa`),
  KEY `fk_tbOrdemServicoTarefa_tbColaborador` (`idColaborador`),
  CONSTRAINT `fk_tbOrdemServicoTarefa_tbColaborador` FOREIGN KEY (`idColaborador`) REFERENCES `tbcolaborador` (`idColaborador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemServicoTarefa_tbListaTarefa` FOREIGN KEY (`idListaTarefa`) REFERENCES `tblistatarefa` (`idListaTarefa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbOrdemServicoTarefa_tbOrdemServicoItem` FOREIGN KEY (`idOrdemServicoItem`) REFERENCES `tbordemservicoitem` (`idOrdemServicoItem`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbpais
CREATE TABLE IF NOT EXISTS `tbpais` (
  `cdPais` smallint(6) NOT NULL,
  `nmPais` varchar(50) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`cdPais`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbpedidoentrada
CREATE TABLE IF NOT EXISTS `tbpedidoentrada` (
  `idPedidoEntrada` bigint(20) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `cdEntidade` int(11) NOT NULL,
  `idColaborador` int(11) NOT NULL,
  `idOrdemServico` bigint(20) DEFAULT NULL,
  `idPedidoEntradaOrigem` bigint(20) DEFAULT NULL,
  `dtPed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `operacao` varchar(2) NOT NULL,
  `vlPed` double NOT NULL,
  `observacao` varchar(100) DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `nrDoc` varchar(15) DEFAULT NULL,
  `dtEmissao` date DEFAULT NULL,
  `dtMov` timestamp NULL DEFAULT NULL,
  `nfAId` varchar(50) DEFAULT NULL,
  `nfBnatOp` varchar(60) DEFAULT NULL,
  `nfBserie` int(11) DEFAULT NULL,
  `nfBcNF` varchar(10) DEFAULT NULL,
  `nfBdEmi` date DEFAULT NULL,
  `nfBdSaiEnt` date DEFAULT NULL,
  `nfBhSaiEnt` time DEFAULT NULL,
  `nfWvBC` float DEFAULT NULL,
  `nfWvICMS` float DEFAULT NULL,
  `nfWvBCST` float DEFAULT NULL,
  `nfWvST` float DEFAULT NULL,
  `nfWvProd` float DEFAULT NULL,
  `nfWvFrete` float DEFAULT NULL,
  `nfWvSeg` float DEFAULT NULL,
  `nfWvDesc` float DEFAULT NULL,
  `nfWvII` float DEFAULT NULL,
  `nfWvIPI` float DEFAULT NULL,
  `nfWvPIS` float DEFAULT NULL,
  `nfWvCOFINS` float DEFAULT NULL,
  `nfWvOutro` float DEFAULT NULL,
  `nfWvNF` float DEFAULT NULL,
  `nfXModFrete` varchar(1) DEFAULT NULL,
  `nfXnVol` int(11) DEFAULT NULL,
  `nfXpesoL` float DEFAULT NULL,
  `nfXpesoB` float DEFAULT NULL,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idPedidoEntrada`),
  KEY `fk_tbPedidoEntrada_tbEntidade` (`cdEntidade`),
  KEY `fk_tbPedidoEntrada_tbColaborador` (`idColaborador`),
  KEY `fk_tbPedidoEntrada_tbLoja` (`idLoja`),
  KEY `fk_tbPedidoEntrada_tbOrdemServico` (`idOrdemServico`),
  KEY `fk_tbPedidoEntrada_tbPedidoEntrada` (`idPedidoEntradaOrigem`),
  CONSTRAINT `fk_tbPedidoEntrada_tbColaborador` FOREIGN KEY (`idColaborador`) REFERENCES `tbcolaborador` (`idColaborador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidoEntrada_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidoEntrada_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidoEntrada_tbOrdemServico` FOREIGN KEY (`idOrdemServico`) REFERENCES `tbordemservico` (`idOrdemServico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidoEntrada_tbPedidoEntrada` FOREIGN KEY (`idPedidoEntradaOrigem`) REFERENCES `tbpedidoentrada` (`idPedidoEntrada`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10583 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbpedidoentradaitem
CREATE TABLE IF NOT EXISTS `tbpedidoentradaitem` (
  `idPedidoEntradaItem` bigint(20) NOT NULL AUTO_INCREMENT,
  `idPedidoEntrada` bigint(20) NOT NULL,
  `idProduto` int(11) NOT NULL,
  `idUnidade` int(11) NOT NULL,
  `quantPedida` float DEFAULT NULL,
  `quant` float DEFAULT NULL,
  `valor` float DEFAULT NULL,
  `loteFab` varchar(20) DEFAULT NULL,
  `dtVal` date DEFAULT NULL,
  `nfINCM` varchar(8) DEFAULT NULL,
  `nfICFOP` varchar(4) DEFAULT NULL,
  `nfNCST` varchar(2) DEFAULT NULL,
  `nfNCSOSN` varchar(4) DEFAULT NULL,
  `nfNvBC` float DEFAULT NULL,
  `nfNvBCST` float DEFAULT NULL,
  `nfNpICMSST` float DEFAULT NULL,
  `nfNvICMSST` float DEFAULT NULL,
  `nfNpICMS` float DEFAULT NULL,
  `nfNvICMS` float DEFAULT NULL,
  `nfOCST` varchar(2) DEFAULT NULL,
  `nfOvBC` float DEFAULT NULL,
  `nfOpIPI` float DEFAULT NULL,
  `nfOvIPI` float DEFAULT NULL,
  `dtmod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idPedidoEntradaItem`),
  KEY `fk_tbPedidoEntradaItem_tbPedidoEntrada` (`idPedidoEntrada`),
  KEY `fk_tbPedidoEntradaItem_tbProduto` (`idProduto`),
  KEY `fk_tbPedidoEntradaItem_tbUnidade` (`idUnidade`),
  CONSTRAINT `fk_tbPedidoEntradaItem_tbPedidoEntrada` FOREIGN KEY (`idPedidoEntrada`) REFERENCES `tbpedidoentrada` (`idPedidoEntrada`),
  CONSTRAINT `fk_tbPedidoEntradaItem_tbProduto` FOREIGN KEY (`idProduto`) REFERENCES `tbproduto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidoEntradaItem_tbUnidade` FOREIGN KEY (`idUnidade`) REFERENCES `tbunidade` (`idUnidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=43796 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbpedidosaida
CREATE TABLE IF NOT EXISTS `tbpedidosaida` (
  `idPedidoSaida` bigint(20) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `cdEntidade` int(11) DEFAULT NULL,
  `idColaborador` int(11) NOT NULL,
  `idEntrega` int(11) DEFAULT NULL,
  `dtPed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtEntrega` timestamp NULL DEFAULT NULL,
  `hrEntrega` varchar(5) DEFAULT NULL,
  `pessoaResponsavel` varchar(60) DEFAULT NULL,
  `operacao` varchar(2) NOT NULL,
  `vlDesc` float DEFAULT NULL,
  `vlPed` double DEFAULT NULL,
  `vlFrete` float DEFAULT NULL,
  `vlServ` float DEFAULT NULL,
  `observacao` varchar(300) DEFAULT NULL,
  `anotacao` varchar(300) DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `dtMov` timestamp NULL DEFAULT NULL,
  `impPedido` varchar(2) DEFAULT 'N',
  `dtInicio` timestamp NULL DEFAULT NULL,
  `dtConclusao` timestamp NULL DEFAULT NULL,
  `dtEntRealizada` timestamp NULL DEFAULT NULL,
  `idOrdemServico` bigint(20) DEFAULT NULL,
  `cdCondPagto` int(11) DEFAULT NULL,
  `cmpPS1` varchar(50) DEFAULT NULL,
  `cmpPS2` varchar(50) DEFAULT NULL,
  `cmpPS3` varchar(50) DEFAULT NULL,
  `cmpPS4` varchar(50) DEFAULT NULL,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  `idMotorista` int(10) DEFAULT NULL,
  `idEntregador` int(10) DEFAULT NULL,
  `statusPag` varchar(2) DEFAULT NULL,
  `tipoPedido` varchar(2) DEFAULT NULL,
  `idMesa` int(11) DEFAULT NULL,
  `quantPessoas` smallint(6) DEFAULT NULL,
  `dtPag` timestamp NULL DEFAULT NULL,
  `idVendedor` int(10) DEFAULT NULL,
  `integracao` varchar(10) DEFAULT NULL,
  `nfe` varchar(3) DEFAULT '''C''',
  PRIMARY KEY (`idPedidoSaida`),
  KEY `fk_tbPedidoSaida_tbLoja` (`idLoja`),
  KEY `fk_tbPedidoSaida_tbColaborador` (`idColaborador`),
  KEY `fk_tbPedidoSaida_tbEntidade` (`cdEntidade`),
  KEY `fk_tbPedidoSaida_tbEntrega` (`idEntrega`),
  KEY `fk_tbPedidoSaida_tbOrdemServico` (`idOrdemServico`),
  KEY `fk_tbPedidoSaida_tbCondPagto` (`cdCondPagto`),
  KEY `fk_tbPedidoSaida_tbMesa` (`idMesa`),
  CONSTRAINT `fk_tbPedidoSaida_tbColaborador` FOREIGN KEY (`idColaborador`) REFERENCES `tbcolaborador` (`idColaborador`),
  CONSTRAINT `fk_tbPedidoSaida_tbCondPagto` FOREIGN KEY (`cdCondPagto`) REFERENCES `tbcondpagto` (`cdCondPagto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidoSaida_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidoSaida_tbEntrega` FOREIGN KEY (`idEntrega`) REFERENCES `tbentrega` (`idEntrega`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidoSaida_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`),
  CONSTRAINT `fk_tbPedidoSaida_tbMesa` FOREIGN KEY (`idMesa`) REFERENCES `tbmesa` (`idMesa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidoSaida_tbOrdemServico` FOREIGN KEY (`idOrdemServico`) REFERENCES `tbordemservico` (`idOrdemServico`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4160321 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbpedidosaidaitem
CREATE TABLE IF NOT EXISTS `tbpedidosaidaitem` (
  `idPedidoSaidaItem` bigint(20) NOT NULL AUTO_INCREMENT,
  `idPedidoSaida` bigint(20) NOT NULL,
  `idProduto` int(11) NOT NULL,
  `idUnidade` int(11) NOT NULL,
  `idAgrupamento` smallint(6) DEFAULT NULL,
  `dsCompProduto` varchar(900) DEFAULT NULL,
  `comp` float DEFAULT NULL,
  `larg` float DEFAULT NULL,
  `quant` float NOT NULL,
  `valor` float NOT NULL,
  `pDesc` float DEFAULT NULL,
  `vlUni` float NOT NULL,
  `impProducao` varchar(2) DEFAULT NULL,
  `numComanda` int(11) DEFAULT NULL,
  `idMesaTransferencia` int(11) DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idPedidoSaidaItem`),
  KEY `fk_tbPedidoSaidaItem_tbProduto` (`idProduto`),
  KEY `fk_tbPedidoSaidaItem_tbUnidade` (`idUnidade`),
  KEY `fk_tbPedidoSaidaItem_tbPedidoSaida` (`idPedidoSaida`),
  KEY `fk_tbPedidoSaidaItem_tbAgrupamento` (`idAgrupamento`),
  CONSTRAINT `fk_tbPedidoSaidaItem_tbAgrupamento` FOREIGN KEY (`idAgrupamento`) REFERENCES `tbagrupamento` (`idAgrupamento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidoSaidaItem_tbPedidoSaida` FOREIGN KEY (`idPedidoSaida`) REFERENCES `tbpedidosaida` (`idPedidoSaida`),
  CONSTRAINT `fk_tbPedidoSaidaItem_tbProduto` FOREIGN KEY (`idProduto`) REFERENCES `tbproduto` (`idProduto`),
  CONSTRAINT `fk_tbPedidoSaidaItem_tbUnidade` FOREIGN KEY (`idUnidade`) REFERENCES `tbunidade` (`idUnidade`)
) ENGINE=InnoDB AUTO_INCREMENT=1832128 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbpedidosaidasubitem
CREATE TABLE IF NOT EXISTS `tbpedidosaidasubitem` (
  `idPedidoSaidaSubItem` bigint(20) NOT NULL AUTO_INCREMENT,
  `idPedidoSaidaItem` bigint(20) NOT NULL,
  `idProduto` int(11) NOT NULL,
  `idUnidade` int(11) DEFAULT NULL,
  `dsCompProduto` varchar(100) DEFAULT NULL,
  `comp` float DEFAULT NULL,
  `larg` float DEFAULT NULL,
  `quant` float DEFAULT NULL,
  `pDesc` float DEFAULT NULL,
  `vlUni` float DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idPedidoSaidaSubItem`),
  KEY `fk_tbPedidoSaidaSubItem_tbPedidoSaidaItem` (`idPedidoSaidaItem`),
  KEY `fk_tbPedidoSaidaSubItem_tbProduto` (`idProduto`),
  KEY `fk_tbPedidoSaidaSubItem_tbUnidade` (`idUnidade`),
  CONSTRAINT `fk_tbPedidoSaidaSubItem_tbPedidoSaidaItem` FOREIGN KEY (`idPedidoSaidaItem`) REFERENCES `tbpedidosaidaitem` (`idPedidoSaidaItem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidoSaidaSubItem_tbProduto` FOREIGN KEY (`idProduto`) REFERENCES `tbproduto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbPedidoSaidaSubItem_tbUnidade` FOREIGN KEY (`idUnidade`) REFERENCES `tbunidade` (`idUnidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbplanoconta
CREATE TABLE IF NOT EXISTS `tbplanoconta` (
  `idPlanoConta` smallint(6) NOT NULL AUTO_INCREMENT,
  `idPlanoContaPai` smallint(6) DEFAULT NULL,
  `nmPlanoConta` varchar(50) NOT NULL,
  `cdPlanoConta` varchar(20) NOT NULL,
  `dc` varchar(1) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idPlanoConta`),
  KEY `fk_tbPlanoConta_tbPlanoConta` (`idPlanoContaPai`),
  CONSTRAINT `fk_tbPlanoConta_tbPlanoConta` FOREIGN KEY (`idPlanoContaPai`) REFERENCES `tbplanoconta` (`idPlanoConta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbpreco
CREATE TABLE IF NOT EXISTS `tbpreco` (
  `idPreco` int(11) NOT NULL AUTO_INCREMENT,
  `idEstoque` int(11) NOT NULL,
  `idUnidade` int(11) NOT NULL,
  `dtInicioPreco` date NOT NULL,
  `dtFimPreco` date DEFAULT NULL,
  `preco` float DEFAULT NULL,
  `custoDireto` float DEFAULT NULL,
  `custoReal` float DEFAULT NULL,
  `custoMedioGeral` float DEFAULT NULL,
  `custoMedioCompra` float DEFAULT NULL,
  `ultimoCustoCompra` float DEFAULT NULL,
  `quantDec` smallint(6) DEFAULT NULL,
  `precoPadrao` varchar(2) DEFAULT 'S',
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idPreco`),
  KEY `fk_tbPreco_tbEstoque` (`idEstoque`),
  KEY `fk_tbPreco_tbUnidade` (`idUnidade`),
  CONSTRAINT `fk_tbPreco_tbEstoque` FOREIGN KEY (`idEstoque`) REFERENCES `tbestoque` (`idEstoque`),
  CONSTRAINT `fk_tbPreco_tbUnidade` FOREIGN KEY (`idUnidade`) REFERENCES `tbunidade` (`idUnidade`)
) ENGINE=InnoDB AUTO_INCREMENT=37284 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbproduto
CREATE TABLE IF NOT EXISTS `tbproduto` (
  `idProduto` int(11) NOT NULL AUTO_INCREMENT,
  `idDivisao` int(11) NOT NULL,
  `idSubGrupo` int(11) NOT NULL,
  `idGrupo` int(11) NOT NULL,
  `nmProduto` varchar(50) NOT NULL,
  `dsProduto` varchar(100) DEFAULT NULL,
  `tipoProduto` varchar(2) NOT NULL,
  `cdProduto` varchar(20) DEFAULT NULL,
  `cdBarra` varchar(20) DEFAULT NULL,
  `cdBarraTrib` varchar(20) DEFAULT NULL,
  `cdExTipi` varchar(3) DEFAULT NULL,
  `cdGenero` varchar(2) DEFAULT NULL,
  `cdNcm` varchar(10) DEFAULT NULL,
  `idCatTributaria` int(11) DEFAULT NULL,
  `cdCfopSaidaDentro` smallint(6) DEFAULT NULL,
  `cdCfopSaidaFora` smallint(6) DEFAULT NULL,
  `idFormacaoPreco` smallint(6) DEFAULT NULL,
  `campo1` varchar(50) DEFAULT NULL,
  `campo2` varchar(50) DEFAULT NULL,
  `campo3` varchar(50) DEFAULT NULL,
  `campo4` varchar(50) DEFAULT NULL,
  `campo5` varchar(50) DEFAULT NULL,
  `quantDec` smallint(6) DEFAULT NULL,
  `quantFatias` smallint(6) DEFAULT NULL,
  `impProducao` varchar(2) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  `cdCest` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`idProduto`),
  KEY `fk_tbProduto_tbNcm` (`cdNcm`),
  KEY `fk_tbProduto_tbCatTributaria` (`idCatTributaria`),
  KEY `fk_tbProduto_tbCfop1` (`cdCfopSaidaDentro`),
  KEY `fk_tbProduto_tbCfop2` (`cdCfopSaidaFora`),
  KEY `fk_tbProduto_tbFormacaoPreco` (`idFormacaoPreco`),
  KEY `fk_tbProduto_tbDivisao` (`idDivisao`),
  CONSTRAINT `fk_tbProduto_tbCatTributaria` FOREIGN KEY (`idCatTributaria`) REFERENCES `tbcattributaria` (`idCatTributaria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbProduto_tbCfop1` FOREIGN KEY (`cdCfopSaidaDentro`) REFERENCES `tbcfop` (`cdCfop`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbProduto_tbCfop2` FOREIGN KEY (`cdCfopSaidaFora`) REFERENCES `tbcfop` (`cdCfop`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbProduto_tbDivisao` FOREIGN KEY (`idDivisao`) REFERENCES `tbdivisao` (`idDivisao`),
  CONSTRAINT `fk_tbProduto_tbFormacaoPreco` FOREIGN KEY (`idFormacaoPreco`) REFERENCES `tbformacaopreco` (`idFormacaoPreco`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbProduto_tbNcm` FOREIGN KEY (`cdNcm`) REFERENCES `tbncm` (`cdNcm`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4937 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbprodutoficha
CREATE TABLE IF NOT EXISTS `tbprodutoficha` (
  `idProdutoFicha` int(11) NOT NULL AUTO_INCREMENT,
  `idProduto` int(11) NOT NULL,
  `info` varchar(200) DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idProdutoFicha`),
  KEY `fk_tbProdutoFicha_tbProduto` (`idProduto`),
  CONSTRAINT `fk_tbProdutoFicha_tbProduto` FOREIGN KEY (`idProduto`) REFERENCES `tbproduto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbprodutofichaitem
CREATE TABLE IF NOT EXISTS `tbprodutofichaitem` (
  `idProdutoFichaItem` int(11) NOT NULL AUTO_INCREMENT,
  `idProdutoFicha` int(11) NOT NULL,
  `idProduto` int(11) NOT NULL,
  `idUnidade` int(11) NOT NULL,
  `quant` float DEFAULT NULL,
  `fixo` varchar(1) DEFAULT NULL,
  `custo` float DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idProdutoFichaItem`),
  KEY `fk_tbProdutoFichaItem_tbProdutoFicha` (`idProdutoFicha`),
  KEY `fk_tbProdutoFichaItem_tbProduto` (`idProduto`),
  KEY `fk_tbProdutoFichaItem_tbUnidade` (`idUnidade`),
  CONSTRAINT `fk_tbProdutoFichaItem_tbProduto` FOREIGN KEY (`idProduto`) REFERENCES `tbproduto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbProdutoFichaItem_tbProdutoFicha` FOREIGN KEY (`idProdutoFicha`) REFERENCES `tbprodutoficha` (`idProdutoFicha`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbProdutoFichaItem_tbUnidade` FOREIGN KEY (`idUnidade`) REFERENCES `tbunidade` (`idUnidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbramoatividade
CREATE TABLE IF NOT EXISTS `tbramoatividade` (
  `idRamoAtividade` smallint(6) NOT NULL AUTO_INCREMENT,
  `dsRamoAtividade` varchar(50) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idRamoAtividade`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbrdf
CREATE TABLE IF NOT EXISTS `tbrdf` (
  `idRDF` bigint(20) NOT NULL AUTO_INCREMENT,
  `idPedidoSaida` bigint(20) NOT NULL,
  `tipo` varchar(2) NOT NULL,
  `nfAversao` float DEFAULT NULL,
  `nfAId` varchar(50) DEFAULT NULL,
  `nfBcUF` int(11) DEFAULT NULL,
  `nfBcNF` int(11) DEFAULT NULL,
  `nfBnatOp` varchar(60) DEFAULT NULL,
  `nfBindPag` int(11) DEFAULT NULL,
  `nfBmod` varchar(2) DEFAULT NULL,
  `nfBserie` int(11) DEFAULT NULL,
  `nfBnNF` int(11) DEFAULT NULL,
  `nfBdEmi` date DEFAULT NULL,
  `nfBdSaiEnt` date DEFAULT NULL,
  `nfBhSaiEnt` time DEFAULT NULL,
  `nfBtpNF` int(11) DEFAULT NULL,
  `nfBcMunFG` int(11) DEFAULT NULL,
  `nfBtpImp` int(11) DEFAULT NULL,
  `nfBtpEmis` int(11) DEFAULT NULL,
  `nfBcDV` int(11) DEFAULT NULL,
  `nfBtpAmb` int(11) DEFAULT NULL,
  `nfBfinNFe` int(11) DEFAULT NULL,
  `nfBprocEmi` int(11) DEFAULT NULL,
  `nfBverProc` varchar(8) DEFAULT NULL,
  `nfCCNPJ` varchar(14) DEFAULT NULL,
  `nfCCPF` varchar(11) DEFAULT NULL,
  `nfCxNome` varchar(60) DEFAULT NULL,
  `nfCxFant` varchar(60) DEFAULT NULL,
  `nfCxLgr` varchar(60) DEFAULT NULL,
  `nfCnro` varchar(60) DEFAULT NULL,
  `nfCxCpl` varchar(60) DEFAULT NULL,
  `nfCxBairro` varchar(60) DEFAULT NULL,
  `nfCcMun` int(11) DEFAULT NULL,
  `nfCxMun` varchar(60) DEFAULT NULL,
  `nfCUF` varchar(2) DEFAULT NULL,
  `nfCCEP` int(11) DEFAULT NULL,
  `nfCcPais` int(11) DEFAULT NULL,
  `nfCxPais` varchar(60) DEFAULT NULL,
  `nfCfone` int(11) DEFAULT NULL,
  `nfCIE` varchar(14) DEFAULT NULL,
  `nfCIEST` varchar(14) DEFAULT NULL,
  `nfCIM` varchar(15) DEFAULT NULL,
  `nfCCNAE` varchar(7) DEFAULT NULL,
  `nfCCRT` int(11) DEFAULT NULL,
  `nfECNPJ` varchar(14) DEFAULT NULL,
  `nfECPF` varchar(11) DEFAULT NULL,
  `nfExNome` varchar(60) DEFAULT NULL,
  `nfExLgr` varchar(60) DEFAULT NULL,
  `nfEnro` varchar(60) DEFAULT NULL,
  `nfExCpl` varchar(60) DEFAULT NULL,
  `nfExBairro` varchar(60) DEFAULT NULL,
  `nfEcMun` int(11) DEFAULT NULL,
  `nfExMun` varchar(60) DEFAULT NULL,
  `nfEUF` varchar(2) DEFAULT NULL,
  `nfECEP` int(11) DEFAULT NULL,
  `nfEcPais` int(11) DEFAULT NULL,
  `nfExPais` varchar(60) DEFAULT NULL,
  `nfEfone` int(11) DEFAULT NULL,
  `nfEIE` varchar(14) DEFAULT NULL,
  `nfEISUF` varchar(9) DEFAULT NULL,
  `nfEemail` varchar(60) DEFAULT NULL,
  `nfFCNPJ` varchar(14) DEFAULT NULL,
  `nfFCPF` varchar(11) DEFAULT NULL,
  `nfFxLgr` varchar(60) DEFAULT NULL,
  `nfFnro` varchar(60) DEFAULT NULL,
  `nfFxCpl` varchar(60) DEFAULT NULL,
  `nfFxBairro` varchar(60) DEFAULT NULL,
  `nfFcMun` int(11) DEFAULT NULL,
  `nfFxMun` varchar(60) DEFAULT NULL,
  `nfFUF` varchar(2) DEFAULT NULL,
  `nfGCNPJ` varchar(14) DEFAULT NULL,
  `nfGCPF` varchar(11) DEFAULT NULL,
  `nfGxLgr` varchar(60) DEFAULT NULL,
  `nfGnro` varchar(60) DEFAULT NULL,
  `nfGxCpl` varchar(60) DEFAULT NULL,
  `nfGxBairro` varchar(60) DEFAULT NULL,
  `nfGcMun` int(11) DEFAULT NULL,
  `nfGxMun` varchar(60) DEFAULT NULL,
  `nfGUF` varchar(2) DEFAULT NULL,
  `nfWvBC` double DEFAULT NULL,
  `nfWvICMS` double DEFAULT NULL,
  `nfWvBCST` double DEFAULT NULL,
  `nfWvST` double DEFAULT NULL,
  `nfWvProd` double DEFAULT NULL,
  `nfWvFrete` double DEFAULT NULL,
  `nfWvSeg` double DEFAULT NULL,
  `nfWvDesc` double DEFAULT NULL,
  `nfWvII` double DEFAULT NULL,
  `nfWvIPI` double DEFAULT NULL,
  `nfWvPIS` double DEFAULT NULL,
  `nfWvCOFINS` double DEFAULT NULL,
  `nfWvOutro` double DEFAULT NULL,
  `nfWvNF` double DEFAULT NULL,
  `nfWvRetPIS` double DEFAULT NULL,
  `nfWvRetCOFINS` double DEFAULT NULL,
  `nfWvRetCSLL` double DEFAULT NULL,
  `nfWvBCIRRF` double DEFAULT NULL,
  `nfWvIRRF` double DEFAULT NULL,
  `nfWvBCRetPrev` double DEFAULT NULL,
  `nfWvRetPrev` double DEFAULT NULL,
  `nfXmodFrete` int(11) DEFAULT NULL,
  `nfXxNome` varchar(60) DEFAULT NULL,
  `nfXIE` varchar(14) DEFAULT NULL,
  `nfXxEnder` varchar(60) DEFAULT NULL,
  `nfXUF` varchar(2) DEFAULT NULL,
  `nfXxMun` varchar(60) DEFAULT NULL,
  `nfXCNPJ` varchar(14) DEFAULT NULL,
  `nfXCPF` varchar(11) DEFAULT NULL,
  `nfXvServ` double DEFAULT NULL,
  `nfXvBCRet` double DEFAULT NULL,
  `nfXpICMSRet` double DEFAULT NULL,
  `nfXvICMSRet` double DEFAULT NULL,
  `nfXCFOP` int(11) DEFAULT NULL,
  `nfXcMunFG` int(11) DEFAULT NULL,
  `nfX22placa` varchar(8) DEFAULT NULL,
  `nfX22UF` varchar(2) DEFAULT NULL,
  `nfX22RNTC` varchar(20) DEFAULT NULL,
  `nfYnFat` varchar(60) DEFAULT NULL,
  `nfYvOrig` double DEFAULT NULL,
  `nfYvDesc` double DEFAULT NULL,
  `nfYvLiq` double DEFAULT NULL,
  `nfZinfCpl` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`idRDF`),
  KEY `fk_tbRDF_tbPedidoSaida` (`idPedidoSaida`),
  CONSTRAINT `fk_tbRDF_tbPedidoSaida` FOREIGN KEY (`idPedidoSaida`) REFERENCES `tbpedidosaida` (`idPedidoSaida`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbrdfdup
CREATE TABLE IF NOT EXISTS `tbrdfdup` (
  `idtbRDFDup` bigint(20) NOT NULL AUTO_INCREMENT,
  `idRDF` bigint(20) NOT NULL,
  `nfYnDup` varchar(60) DEFAULT NULL,
  `nfYdVenc` date DEFAULT NULL,
  `nfYvDup` double DEFAULT NULL,
  PRIMARY KEY (`idtbRDFDup`),
  KEY `fk_tbRDFDup_tbRDF` (`idRDF`),
  CONSTRAINT `fk_tbRDFDup_tbRDF` FOREIGN KEY (`idRDF`) REFERENCES `tbrdf` (`idRDF`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbrdfitem
CREATE TABLE IF NOT EXISTS `tbrdfitem` (
  `idRDFItem` bigint(20) NOT NULL AUTO_INCREMENT,
  `idRDF` bigint(20) NOT NULL,
  `idCatTributaria` int(11) DEFAULT NULL,
  `nfHnItem` int(11) DEFAULT NULL,
  `nfHinfAdProd` varchar(500) DEFAULT NULL,
  `nfIcProd` varchar(60) DEFAULT NULL,
  `nfIcEAN` varchar(14) DEFAULT NULL,
  `nfIxProd` varchar(120) DEFAULT NULL,
  `nfINCM` varchar(8) DEFAULT NULL,
  `nfIEXTIPI` varchar(3) DEFAULT NULL,
  `nfIgenero` int(11) DEFAULT NULL,
  `nfICFOP` int(11) DEFAULT NULL,
  `nfIuCom` varchar(6) DEFAULT NULL,
  `nfIqCom` double DEFAULT NULL,
  `nfIvUnCom` double DEFAULT NULL,
  `nfIvProd` double DEFAULT NULL,
  `nfIcEANTrib` varchar(14) DEFAULT NULL,
  `nfIuTrib` varchar(6) DEFAULT NULL,
  `nfIqTrib` double DEFAULT NULL,
  `nfIvUnTrib` double DEFAULT NULL,
  `nfIvFrete` double DEFAULT NULL,
  `nfIvSeg` double DEFAULT NULL,
  `nfIvDesc` double DEFAULT NULL,
  `nfIvOutro` double DEFAULT NULL,
  `nfIindTot` int(11) DEFAULT NULL,
  `nfNorig` int(11) DEFAULT NULL,
  `nfNCST` varchar(3) DEFAULT NULL,
  `nfNmodBC` int(11) DEFAULT NULL,
  `nfNpRedBC` double DEFAULT NULL,
  `nfNvBC` double DEFAULT NULL,
  `nfNpICMS` double DEFAULT NULL,
  `nfNvICMS` double DEFAULT NULL,
  `nfNmodBCST` int(11) DEFAULT NULL,
  `nfNpMVAST` double DEFAULT NULL,
  `nfNpRedBCST` double DEFAULT NULL,
  `nfNvBCST` double DEFAULT NULL,
  `nfNpICMSST` double DEFAULT NULL,
  `nfNvICMSST` double DEFAULT NULL,
  `nfNvBCSTRet` double DEFAULT NULL,
  `nfNvICMSSRet` double DEFAULT NULL,
  `nfNvBCSTDest` double DEFAULT NULL,
  `nfNvICMSSTDest` double DEFAULT NULL,
  `nfNmotDesICMS` int(11) DEFAULT NULL,
  `nfNpBCOp` double DEFAULT NULL,
  `nfNUFST` varchar(2) DEFAULT NULL,
  `nfNpCredSN` double DEFAULT NULL,
  `nfNvCredICMSSN` double DEFAULT NULL,
  `nfOclEnq` varchar(5) DEFAULT NULL,
  `nfOCNPJProd` varchar(14) DEFAULT NULL,
  `nfOcSelo` varchar(60) DEFAULT NULL,
  `nfOqSelo` double DEFAULT NULL,
  `nfOcEnq` varchar(3) DEFAULT NULL,
  `nfOCST` varchar(2) DEFAULT NULL,
  `nfOvBC` double DEFAULT NULL,
  `nfOpIPI` double DEFAULT NULL,
  `nfOvIPI` double DEFAULT NULL,
  `nfOqUnid` double DEFAULT NULL,
  `nfOvUnid` double DEFAULT NULL,
  `nfPvBC` double DEFAULT NULL,
  `nfPvDespAdu` double DEFAULT NULL,
  `nfPvII` double DEFAULT NULL,
  `nfPvIOF` double DEFAULT NULL,
  `nfQCST` varchar(2) DEFAULT NULL,
  `nfQvBC` double DEFAULT NULL,
  `nfQpPIS` double DEFAULT NULL,
  `nfQvPIS` double DEFAULT NULL,
  `nfQqBCProd` double DEFAULT NULL,
  `nfQvAliqProd` double DEFAULT NULL,
  `nfSCST` varchar(2) DEFAULT NULL,
  `nfSvBC` double DEFAULT NULL,
  `nfSpCOFINS` double DEFAULT NULL,
  `nfSvCOFINS` double DEFAULT NULL,
  `nfSqBCProd` double DEFAULT NULL,
  `nfSvAliqProd` double DEFAULT NULL,
  `nfTvBC` double DEFAULT NULL,
  `nfTpCOFINS` double DEFAULT NULL,
  `nfTvCOFINS` double DEFAULT NULL,
  `nfTqBCProd` double DEFAULT NULL,
  `nfTvAliqProd` double DEFAULT NULL,
  `nfUvBC` double DEFAULT NULL,
  `nfUvAliq` double DEFAULT NULL,
  `nfUvISSQN` double DEFAULT NULL,
  `nfUcMunFG` varchar(7) DEFAULT NULL,
  `nfUcListServ` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`idRDFItem`),
  KEY `fk_tbRDFItem_tbRDF` (`idRDF`),
  KEY `fk_tbRDFItem_tbCatTributaria` (`idCatTributaria`),
  CONSTRAINT `fk_tbRDFItem_tbCatTributaria` FOREIGN KEY (`idCatTributaria`) REFERENCES `tbcattributaria` (`idCatTributaria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbRDFItem_tbRDF` FOREIGN KEY (`idRDF`) REFERENCES `tbrdf` (`idRDF`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbrecibo
CREATE TABLE IF NOT EXISTS `tbrecibo` (
  `idRecibo` int(11) NOT NULL AUTO_INCREMENT,
  `idLoja` int(11) NOT NULL,
  `cdEntidade` int(11) DEFAULT NULL,
  `favorecido` varchar(60) DEFAULT NULL,
  `valor` double DEFAULT NULL,
  `referente` varchar(400) DEFAULT NULL,
  `observacao` varchar(100) DEFAULT NULL,
  `emitente` varchar(60) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `cpfCnpj` varchar(18) DEFAULT NULL,
  `cidade` varchar(40) DEFAULT NULL,
  `dtEmissao` date DEFAULT NULL,
  `idContaMovto` bigint(20) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idRecibo`),
  KEY `fk_tbRecibo_tbEntidade` (`cdEntidade`),
  KEY `fk_tbRecibo_tbContaMovto` (`idContaMovto`),
  KEY `fk_tbRecibo_tbLoja` (`idLoja`),
  CONSTRAINT `fk_tbRecibo_tbContaMovto` FOREIGN KEY (`idContaMovto`) REFERENCES `tbcontamovto` (`idContaMovto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbRecibo_tbEntidade` FOREIGN KEY (`cdEntidade`) REFERENCES `tbentidade` (`cdEntidade`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbRecibo_tbLoja` FOREIGN KEY (`idLoja`) REFERENCES `tbloja` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbregiao
CREATE TABLE IF NOT EXISTS `tbregiao` (
  `cdRegiao` smallint(6) NOT NULL,
  `nmRegiao` varchar(40) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`cdRegiao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbrelacaounidade
CREATE TABLE IF NOT EXISTS `tbrelacaounidade` (
  `idRelacaoUnidade` int(11) NOT NULL AUTO_INCREMENT,
  `idUnidadeDe` int(11) NOT NULL,
  `idUnidadePara` int(11) NOT NULL,
  `fatorConversao` float NOT NULL,
  PRIMARY KEY (`idRelacaoUnidade`),
  UNIQUE KEY `uk_tbRelacaoUnidade_idUnidade` (`idUnidadeDe`,`idUnidadePara`),
  KEY `fk_tbRelacaoUnidade_tbUnidade_Para` (`idUnidadePara`),
  KEY `fk_tbRelacaoUnidade_tbUnidade_De` (`idUnidadeDe`),
  CONSTRAINT `fk_tbRelacaoUnidade_tbUnidade_De` FOREIGN KEY (`idUnidadeDe`) REFERENCES `tbunidade` (`idUnidade`),
  CONSTRAINT `fk_tbRelacaoUnidade_tbUnidade_Para` FOREIGN KEY (`idUnidadePara`) REFERENCES `tbunidade` (`idUnidade`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbretornonotafiscal
CREATE TABLE IF NOT EXISTS `tbretornonotafiscal` (
  `idRetornoNotaFiscal` int(10) NOT NULL AUTO_INCREMENT,
  `idPedidoSaida` int(11) DEFAULT NULL,
  `mensagemRetorno` varchar(3000) DEFAULT NULL,
  `dtRegistro` date DEFAULT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  KEY `id_retorno_nota_fical` (`idRetornoNotaFiscal`)
) ENGINE=InnoDB AUTO_INCREMENT=1117 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbretornonotafiscalcancelamento
CREATE TABLE IF NOT EXISTS `tbretornonotafiscalcancelamento` (
  `idRetornoNotaFiscalCanc` int(11) NOT NULL AUTO_INCREMENT,
  `idRetornoNotaFiscal` int(11) DEFAULT NULL,
  `idPedidoSaida` int(11) DEFAULT NULL,
  `mensagemRetorno` varchar(3000) NOT NULL DEFAULT '0',
  `justificativa` varchar(3000) DEFAULT NULL,
  `dtRegistro` timestamp NULL DEFAULT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idRetornoNotaFiscalCanc`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbretornonotafiscalcorrecao
CREATE TABLE IF NOT EXISTS `tbretornonotafiscalcorrecao` (
  `idNotaFiscalCorrecao` int(11) NOT NULL AUTO_INCREMENT,
  `idRetornoNotaFiscal` int(11) NOT NULL,
  `mensagemRetorno` varchar(3000) NOT NULL,
  `idPedidoSaida` int(11) NOT NULL,
  `justificativa` varchar(3000) NOT NULL DEFAULT '0',
  `dtRegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(50) NOT NULL,
  PRIMARY KEY (`idNotaFiscalCorrecao`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbsubgrupo
CREATE TABLE IF NOT EXISTS `tbsubgrupo` (
  `idSubGrupo` int(11) NOT NULL AUTO_INCREMENT,
  `idGrupo` int(11) NOT NULL,
  `dsSubGrupo` varchar(40) NOT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idSubGrupo`),
  KEY `fk_tbSubGrupo_tbGrupo` (`idGrupo`),
  CONSTRAINT `fk_tbSubGrupo_tbGrupo` FOREIGN KEY (`idGrupo`) REFERENCES `tbgrupo` (`idGrupo`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtipoatendimento
CREATE TABLE IF NOT EXISTS `tbtipoatendimento` (
  `cdTipoAtendimento` int(11) NOT NULL AUTO_INCREMENT,
  `dsTipoAtendimento` varchar(40) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`cdTipoAtendimento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtipocolaborador
CREATE TABLE IF NOT EXISTS `tbtipocolaborador` (
  `idTipoColaborador` smallint(6) NOT NULL AUTO_INCREMENT,
  `dsTipoColaborador` varchar(30) NOT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idTipoColaborador`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtipoconta
CREATE TABLE IF NOT EXISTS `tbtipoconta` (
  `idTipoConta` smallint(6) NOT NULL AUTO_INCREMENT,
  `dsTipoConta` varchar(40) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idTipoConta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtipodependente
CREATE TABLE IF NOT EXISTS `tbtipodependente` (
  `idTipoDependente` smallint(6) NOT NULL,
  `dsTipoDependente` varchar(20) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idTipoDependente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtipodocumento
CREATE TABLE IF NOT EXISTS `tbtipodocumento` (
  `idTipoDocumento` smallint(6) NOT NULL AUTO_INCREMENT,
  `dsTipoDocumento` varchar(40) NOT NULL,
  `cdTipoDocumento` varchar(10) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idTipoDocumento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtipoemail
CREATE TABLE IF NOT EXISTS `tbtipoemail` (
  `cdTipoEmail` smallint(6) NOT NULL,
  `dsTipoEmail` varchar(30) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`cdTipoEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtipoendereco
CREATE TABLE IF NOT EXISTS `tbtipoendereco` (
  `cdTipoEndereco` smallint(6) NOT NULL,
  `dsTipoEndereco` varchar(30) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`cdTipoEndereco`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtipoentidade
CREATE TABLE IF NOT EXISTS `tbtipoentidade` (
  `idTipoEntidade` smallint(6) NOT NULL AUTO_INCREMENT,
  `dsTipoEntidade` varchar(30) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idTipoEntidade`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtipoespecie
CREATE TABLE IF NOT EXISTS `tbtipoespecie` (
  `cdTipoEspecie` int(11) NOT NULL AUTO_INCREMENT,
  `dsTipoEspecie` varchar(30) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`cdTipoEspecie`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtipofrequencia
CREATE TABLE IF NOT EXISTS `tbtipofrequencia` (
  `cdTipoFrequencia` smallint(6) NOT NULL AUTO_INCREMENT,
  `dsTipoFrequencia` varchar(20) NOT NULL,
  `nrDias` smallint(6) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`cdTipoFrequencia`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtipologradouro
CREATE TABLE IF NOT EXISTS `tbtipologradouro` (
  `cdTipoLogradouro` smallint(6) NOT NULL,
  `AbrevTipoLogradouro` varchar(5) NOT NULL,
  `dsTipoLogradouro` varchar(30) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`cdTipoLogradouro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtiponivel
CREATE TABLE IF NOT EXISTS `tbtiponivel` (
  `cdTipoNivel` smallint(6) NOT NULL,
  `dsTipoNivel` varchar(20) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`cdTipoNivel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtiporaca
CREATE TABLE IF NOT EXISTS `tbtiporaca` (
  `idTipoRaca` smallint(6) NOT NULL AUTO_INCREMENT,
  `dsTipoRaca` varchar(30) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`idTipoRaca`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtipotelefone
CREATE TABLE IF NOT EXISTS `tbtipotelefone` (
  `cdTipoTelefone` smallint(6) NOT NULL,
  `dsTipoTelefone` varchar(30) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`cdTipoTelefone`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtransferencia
CREATE TABLE IF NOT EXISTS `tbtransferencia` (
  `idTransferencia` bigint(20) NOT NULL AUTO_INCREMENT,
  `idContaDe` smallint(6) NOT NULL,
  `idContaPara` smallint(6) NOT NULL,
  `valor` double NOT NULL,
  `formaMovto` varchar(2) NOT NULL,
  `dtLanc` date NOT NULL,
  `LancaAutomatico` varchar(1) NOT NULL,
  `historico` varchar(200) DEFAULT NULL,
  `cdTipoFrequencia` smallint(6) DEFAULT NULL,
  `informaParcelas` varchar(1) DEFAULT NULL,
  `quantParcelas` smallint(6) DEFAULT NULL,
  `dtUltimoLanc` date DEFAULT NULL,
  `idColaborador` int(11) DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idTransferencia`),
  KEY `fk_tbTransferencia_tbContaDe` (`idContaDe`),
  KEY `fk_tbTransferencia_tbContaPara` (`idContaPara`),
  KEY `fk_tbTransferencia_tbTipoFrequencia` (`cdTipoFrequencia`),
  KEY `fk_tbTransferencia_tbColaborador` (`idColaborador`),
  CONSTRAINT `fk_tbTransferencia_tbColaborador` FOREIGN KEY (`idColaborador`) REFERENCES `tbcolaborador` (`idColaborador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbTransferencia_tbContaDe` FOREIGN KEY (`idContaDe`) REFERENCES `tbconta` (`idConta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbTransferencia_tbContaPara` FOREIGN KEY (`idContaPara`) REFERENCES `tbconta` (`idConta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbTransferencia_tbTipoFrequencia` FOREIGN KEY (`cdTipoFrequencia`) REFERENCES `tbtipofrequencia` (`cdTipoFrequencia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtribservico
CREATE TABLE IF NOT EXISTS `tbtribservico` (
  `idTribServico` smallint(6) NOT NULL AUTO_INCREMENT,
  `sigla` varchar(20) NOT NULL,
  `aliquota` float DEFAULT NULL,
  `pRetencao` float DEFAULT NULL,
  PRIMARY KEY (`idTribServico`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbtributacao
CREATE TABLE IF NOT EXISTS `tbtributacao` (
  `idTributacao` int(11) NOT NULL AUTO_INCREMENT,
  `idCatTributaria` int(11) NOT NULL,
  `cdEstado` smallint(6) NOT NULL,
  `crt` varchar(1) NOT NULL,
  `cdCstIcms` smallint(6) DEFAULT NULL,
  `cdCsosn` smallint(6) DEFAULT NULL,
  `origem` varchar(1) DEFAULT NULL,
  `modBCIcms` varchar(1) DEFAULT NULL,
  `pReduBCIcms` float DEFAULT NULL,
  `pBCOperacao` float DEFAULT NULL,
  `pMargemIcms` float DEFAULT NULL,
  `aliquotaIcms` float DEFAULT NULL,
  `modBCIcmsST` varchar(1) DEFAULT NULL,
  `pReduBCIcmsST` float DEFAULT NULL,
  `pMargemIcmsST` float DEFAULT NULL,
  `aliquotaIcmsST` float DEFAULT NULL,
  `cdEstadoIcmsST` smallint(6) DEFAULT NULL,
  `aliquotaCredito` float DEFAULT NULL,
  `observacao` varchar(200) DEFAULT NULL,
  `percCargaTrib` float DEFAULT NULL,
  `dtMod` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idTributacao`),
  KEY `fk_tbTributacao_tbCatTributaria` (`idCatTributaria`),
  KEY `fk_tbTributacao_tbEstado1` (`cdEstado`),
  KEY `fk_tbTributacao_tbCstIcms` (`cdCstIcms`),
  KEY `fk_tbTributacao_tbEstado2` (`cdEstadoIcmsST`),
  KEY `fk_tbTributacao_tbCsosn` (`cdCsosn`),
  CONSTRAINT `fk_tbTributacao_tbCatTributaria` FOREIGN KEY (`idCatTributaria`) REFERENCES `tbcattributaria` (`idCatTributaria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbTributacao_tbCsosn` FOREIGN KEY (`cdCsosn`) REFERENCES `tbcsosn` (`cdCsosn`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbTributacao_tbCstIcms` FOREIGN KEY (`cdCstIcms`) REFERENCES `tbcsticms` (`cdCstIcms`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbTributacao_tbEstado1` FOREIGN KEY (`cdEstado`) REFERENCES `tbestado` (`cdEstado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbTributacao_tbEstado2` FOREIGN KEY (`cdEstadoIcmsST`) REFERENCES `tbestado` (`cdEstado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbunidade
CREATE TABLE IF NOT EXISTS `tbunidade` (
  `idUnidade` int(11) NOT NULL AUTO_INCREMENT,
  `dsUnidade` varchar(40) NOT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idUnidade`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
-- Copiando estrutura para tabela afero.tbusuario
CREATE TABLE IF NOT EXISTS `tbusuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `idGrupoUsuario` smallint(6) NOT NULL,
  `email` varchar(100) NOT NULL,
  `login` varchar(20) NOT NULL,
  `senha` varchar(40) NOT NULL,
  `status` varchar(1) NOT NULL,
  `dtCad` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtMod` timestamp NULL DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `uk_tbUsuario_login` (`login`),
  KEY `fk_tbUsuario_tbGrupoUsuario` (`idGrupoUsuario`),
  CONSTRAINT `fk_tbUsuario_tbGrupoUsuario` FOREIGN KEY (`idGrupoUsuario`) REFERENCES `tbgrupousuario` (`idGrupoUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
