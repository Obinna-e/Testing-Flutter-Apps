import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_tutorial/article.dart';
import 'package:flutter_testing_tutorial/news_change_notifier.dart';
import 'package:flutter_testing_tutorial/news_service.dart';
import 'package:mocktail/mocktail.dart';

//Bad because makes everything convoluded.
class BadMockNewsService implements NewsService {
  bool getArticlesCalled = false;
  @override
  Future<List<Article>> getArticles() async {
    getArticlesCalled = true;
    return [
      Article(title: 'Test 1', content: 'Test 1 content'),
      Article(title: 'Test 2', content: 'Test 2 content'),
      Article(title: 'Test 3', content: 'Test 3 content'),
    ];
  }
}

class MockNewsService extends Mock implements NewsService {}

void main() {
  //sut = system under test
  late NewsChangeNotifier sut;
  late MockNewsService mockNewsService;

  //setup method runs before every test
  setUp(() {
    mockNewsService = MockNewsService();
    sut = NewsChangeNotifier(mockNewsService);
  });

  test("initial values are correct", () {
    expect(sut.articles, []);
    expect(sut.isLoading, false);
  });

  group('getArticles', () {
    test("gets articles using the NewsService", () async {
      when(() => mockNewsService.getArticles()).thenAnswer((_) async => []);
      await sut.getArticles();
      verify(() => mockNewsService.getArticles()).called(1);
    });
  });

  test(
    "",
    () async {},
  );
}
