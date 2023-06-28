enum CharacterStatus {
  alive,
  dead,
  unknown,
  other,
}

class ItemStatus {
  CharacterStatus getItemStatus(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return CharacterStatus.alive;
      case 'dead':
        return CharacterStatus.dead;
      case 'unknown':
        return CharacterStatus.unknown;
      default:
        return CharacterStatus.other;
    }
  }

  String getItemIcon(CharacterStatus status) {
    switch (status) {
      case CharacterStatus.alive:
        return '🟢';
      case CharacterStatus.dead:
        return '🔴';
      case CharacterStatus.unknown:
        return '⚪️';
      default:
        return '⚫️';
    }
  }
}
