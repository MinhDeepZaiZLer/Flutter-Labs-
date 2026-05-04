import 'story.dart';

class StoryBrain {
  int _storyNumber = 0;

  final List<Story> _storyData = [
    Story( // Story 0
        storyTitle: 'Bạn đang đi trên một con đường đất vắng vẻ thì xe bị hỏng. Không có sóng điện thoại. Màn đêm buông xuống.',
        choice1: 'Đi bộ dọc theo con đường để tìm sự giúp đỡ.',
        choice2: 'Chui vào xe khóa trái cửa và chờ đến sáng.'),
    Story( // Story 1
        storyTitle: 'Bạn đi bộ được một lúc thì thấy một người lái xe tải dừng lại. Anh ta vẫy bạn lên xe.',
        choice1: 'Lên xe luôn, có còn hơn không.',
        choice2: 'Hỏi anh ta xem anh ta định đi đâu trước khi lên.'),
    Story( // Story 2
        storyTitle: 'Bạn khóa trái cửa. Đột nhiên có tiếng gõ cửa kính. Bạn thấy một bóng đen đang đứng ngoài.',
        choice1: 'Mở cửa sổ hé một chút để nói chuyện.',
        choice2: 'Giả vờ ngủ không quan tâm.'),
    Story( // Story 3 (Kết thúc)
        storyTitle: 'Bạn an toàn về đến nhà. Kết thúc tốt đẹp.',
        choice1: 'Chơi lại',
        choice2: ''),
    Story( // Story 4 (Kết thúc)
        storyTitle: 'Người lái xe hóa ra là một tên cướp. Bạn mất hết tiền. Kết thúc buồn.',
        choice1: 'Chơi lại',
        choice2: ''),
    Story( // Story 5 (Kết thúc)
        storyTitle: 'Bóng đen đập vỡ cửa kính. Chuyện tồi tệ đã xảy ra. Kết thúc tồi tệ.',
        choice1: 'Chơi lại',
        choice2: '')
  ];

  String getStory() { return _storyData[_storyNumber].storyTitle; }
  String getChoice1() { return _storyData[_storyNumber].choice1; }
  String getChoice2() { return _storyData[_storyNumber].choice2; }

  void nextStory(int choiceNumber) {
    // Logic rẽ nhánh cốt truyện
    if (choiceNumber == 1 && _storyNumber == 0) { _storyNumber = 1; }
    else if (choiceNumber == 2 && _storyNumber == 0) { _storyNumber = 2; }
    else if (choiceNumber == 1 && _storyNumber == 1) { _storyNumber = 4; }
    else if (choiceNumber == 2 && _storyNumber == 1) { _storyNumber = 3; }
    else if (choiceNumber == 1 && _storyNumber == 2) { _storyNumber = 5; }
    else if (choiceNumber == 2 && _storyNumber == 2) { _storyNumber = 4; }
    // Nếu đang ở các story kết thúc (3, 4, 5) thì reset game
    else if (_storyNumber == 3 || _storyNumber == 4 || _storyNumber == 5) { restart(); }
  }

  void restart() { _storyNumber = 0; }

  // Ẩn nút số 2 nếu đã đi đến kết truyện (vì kết truyện chỉ có 1 nút "Chơi lại")
  bool buttonShouldBeVisible() {
    return _storyNumber == 0 || _storyNumber == 1 || _storyNumber == 2;
  }
}