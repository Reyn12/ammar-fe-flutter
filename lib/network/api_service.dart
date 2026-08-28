import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'dio_client_provider.dart';
import 'environment.dart';

part 'api_service.g.dart';

@riverpod
ApiService apiService(Ref ref) {
  final dio = ref.watch(dioClientProvider);
  return ApiService(dio);
}

class ApiService {
  ApiService(this.dio);

  final Dio dio;

  bool useMock(bool? mock) => mock ?? mockStatus;

  // Future<List<ProductModel>> fetchProducts({bool? mock}) async {
  //   if (useMock(mock)) return ProductMocks.list;

  //   final res = await dio.get('/products');
  //   return Converter.list(res.data, ProductModel.fromJson);
  // }
}
