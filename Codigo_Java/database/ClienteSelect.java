package database;

import model.Cliente;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClienteSelect {

    public static List<Cliente> listarClientes() {
        List<Cliente> clientes = new ArrayList<>();

        String comando = "SELECT * FROM clientes";

        try (Connection conexao = Conexao.conectar();
             PreparedStatement stmt = conexao.prepareStatement(comando);
             ResultSet resultado = stmt.executeQuery()) {

            while (resultado.next()) {

                Cliente cliente = new Cliente(
                        resultado.getInt("id_cliente"),
                        resultado.getString("nome"),
                        resultado.getString("telefone")
                );

                clientes.add(cliente);
            }

        } catch (SQLException e) {
            System.err.println("Erro ao buscar clientes: " + e.getMessage());
        }

        return clientes;
    }

    public static Cliente buscarPorId(int id) {

        String sql = "SELECT * FROM clientes WHERE id_cliente = ?";

        try (Connection conexao = Conexao.conectar();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet resultado = stmt.executeQuery()) {

                if (resultado.next()) {

                    return new Cliente(
                            resultado.getInt("id_cliente"),
                            resultado.getString("nome"),
                            resultado.getString("telefone")
                    );
                }
            }

        } catch (SQLException e) {
            System.err.println("Erro ao buscar cliente: " + e.getMessage());
        }

        return null;
    }
}
