
import database.ClienteSelect;
import model.Cliente;

import java.util.List;

public class Main {

    public static void main(String[] args) {
        buscarClientesPorID(2);
    }

    public static void listarClientes() {
        List<Cliente> clientes = ClienteSelect.listarClientes();

        for (Cliente cliente : clientes) {
            System.out.println("ID: " + cliente.getIdCliente());
            System.out.println("Nome: " + cliente.getNome());
            System.out.println("Telefone: " + cliente.getTelefone());

            System.out.println("-------------------");
        }
    }

    public static void buscarClientesPorID(int id) {
        Cliente cliente = ClienteSelect.buscarPorId(id);

        if (cliente != null) {

            System.out.println("ID: " + cliente.getIdCliente());
            System.out.println("Nome: " + cliente.getNome());
            System.out.println("Telefone: " + cliente.getTelefone());

        } else {
            System.out.println("Cliente não encontrado!");
        }
    }
}
