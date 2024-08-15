enum SupabaseDBName {
  counties('countries', '국가'),
  ;

  final String dbName;
  final String dbKorName;
  const SupabaseDBName(this.dbName, this.dbKorName);
}
