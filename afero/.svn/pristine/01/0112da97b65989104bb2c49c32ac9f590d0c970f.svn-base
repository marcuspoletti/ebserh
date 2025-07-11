package afero.test;


import java.sql.Connection;
import java.util.Iterator;
import java.util.List;

import afero.model.Produto;
import afero.model.Estoque;
import afero.model.Preco;
import afero.persistence.AferoDAOException;
import afero.persistence.ProdutoDAO;
import afero.persistence.EstoqueDAO;
import afero.persistence.PrecoDAO;
import afero.util.ConnectionFactory;

public class TestEstoqueDuplicado {

	/**
	 * @param args
	 * @throws AferoDAOException
	 * Pesquisa todos os produtos e exclui os com estoque duplicado
	 */
	public static void main(String[] args) throws AferoDAOException {
		// TODO Auto-generated method stub

		Connection conn = null;
		conn = ConnectionFactory.getConnection();

		Produto produto;
		ProdutoDAO daoProduto = new ProdutoDAO(conn);
		Estoque estoque;
		EstoqueDAO daoEstoque = new EstoqueDAO(conn);
		Preco preco;
		PrecoDAO daoPreco = new PrecoDAO(conn);

		List listProduto;
		List listEstoque;
		List listPreco;
		boolean exclui;

		//produtos
		listProduto = daoProduto.listarProduto("");
		for (Iterator itProduto = listProduto.iterator(); itProduto.hasNext();) {
			produto = (Produto) itProduto.next();
			
			//estoques
			listEstoque = daoEstoque.procurarEstoquePreco(produto.getIdProduto(), 2);
			exclui = false;
			if (listEstoque.size() > 1) {
				for (Iterator itEstoque = listEstoque.iterator(); itEstoque.hasNext();) {
					estoque = (Estoque) itEstoque.next();
					System.out.print(estoque.getIdEstoque() + "\t"
							+ estoque.getIdProduto() + "\t"
							+ estoque.getIdLoja() + "\t");
					if (exclui) {
						//precos
						listPreco = daoPreco.procurarPrecoEstoqueList(estoque.getIdEstoque());
						for (Iterator itPreco = listPreco.iterator(); itPreco.hasNext();) {
							//exclui precos do estoque duplicado
							preco = (Preco) itPreco.next();
							daoPreco.excluir(preco);
						}

						//exclui estoque duplicado
						daoEstoque.excluir(estoque);
						System.out.println(" --> Excluído!");
						
					} else {
						System.out.println("OI");
						exclui = true;
					}
				}
			}
		}
	}
	
}
