import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

class ListScreenHelper {
  /// Cria o indicador de status (habilitado/desabilitado)
  static Widget buildStatusIndicator(bool enabled) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: enabled ? Colors.green.withAlpha(32) : Colors.red.withAlpha(32),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              enabled ? Colors.green.withAlpha(100) : Colors.red.withAlpha(100),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            enabled ? Icons.check_circle : Icons.cancel,
            size: 12,
            color: enabled ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 4),
          Text(
            enabled ? 'Habilitado' : 'Desabilitado',
            style: TextStyle(
              fontSize: 10,
              color: enabled ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Cria o item do menu para habilitar/desabilitar
  static PopupMenuItem<String> buildToggleMenuItem(String value, bool enabled) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(
            enabled ? Icons.visibility_off : Icons.visibility,
            color: enabled ? Colors.orange : Colors.green,
          ),
          const SizedBox(width: 8),
          Text(enabled ? 'Desabilitar' : 'Habilitar'),
        ],
      ),
    );
  }

  /// Alterna o status de um item
  static Future<void> toggleEnabled(
    BuildContext context,
    String tableName,
    Map<String, dynamic> item,
    String itemName,
    VoidCallback onSuccess,
  ) async {
    final currentStatus = item['enabled'] ?? true;
    final newStatus = !currentStatus;

    try {
      await SupabaseService.client
          .from(tableName)
          .update({'enabled': newStatus})
          .eq('id', item['id']);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$itemName ${newStatus ? 'habilitado' : 'desabilitado'} com sucesso!',
            ),
            backgroundColor: newStatus ? Colors.green : Colors.orange,
          ),
        );
      }

      onSuccess();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao alterar status do $itemName: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
