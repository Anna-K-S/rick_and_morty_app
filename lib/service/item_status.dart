class ItemStatus {
  String itemIcon(String status) => status == 'Alive'
      ? '🟢'
      : status == 'Dead'
          ? '🔴'
          : status == 'unknown'
              ? '⚪️'
              : '⚫️';
}
