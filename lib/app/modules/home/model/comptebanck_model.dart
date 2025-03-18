class ComptebanckModel {
  final int id;
  final String numbanck;  

 ComptebanckModel({
    required this.id,
    required this.numbanck,    
  });

  factory ComptebanckModel.fromJson(Map<String, dynamic> json) {
    return ComptebanckModel(
      id: json['id'] ?? 0,
      numbanck: json['numbanck'] ?? '',      
    );
  }
}
