import 'question.dart';

class QuizBrain {
  int _questionNumber = 0; // Thêm dấu gạch dưới '_' để private biến này, bảo mật dữ liệu

  // Danh sách câu hỏi (cũng private)
  final List<Question> _questionBank = [
    Question('Con người có thể nín thở dưới nước 1 tiếng đồng hồ mà không cần thiết bị?', false),
    Question('Dơi bị mù?', false),
    Question('Trái đất là hành tinh thứ 3 tính từ mặt trời?', true),
    Question('Châu Úc rộng hơn mặt trăng?', true),
    Question('Tim của tôm nằm ở trên đầu của nó?', true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  // Hàm check xem đã hết câu hỏi chưa
  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  // Hàm reset game
  void reset() {
    _questionNumber = 0;
  }
}