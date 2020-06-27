import 'package:flutter/cupertino.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/model/model.dart';
import 'package:flutter_web/services/services.dart';
import 'package:flutter_web/states/state_admin_article.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oktoast/oktoast.dart';

class StateAdminArticleAdd extends ViewStateModel {
  String _title;
  String _contentType;
  String _content;

  final StateAdminArticle articleState;

  StateAdminArticleAdd({
    @required this.articleState,
  });

  Subject _selectSubject;
  List<Tag> _selectTags = [];
  List<Tag> get selectTags => _selectTags;

  Subject get selectSubject => _selectSubject;

  List<Subject> _subjects = [];
  List<Subject> get subjects => _subjects;

  List<Tag> _tags = [];
  List<Tag> get tags => _tags;

  final repository = locator<WebRepository>();

  Future loadData() async {
    setBusy();
    try {
      _tags = await repository.getAllTags();
      _subjects = await repository.getAllSubject();
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  void setTitle(String title) {
    _title = title;
  }

  void setSubject(Subject subject) {
    _selectSubject = subject;
    notifyListeners();
  }

  void setContentType(String contentType) {
    _contentType = contentType;
  }

  void setContent(String content) {
    _content = content;
  }

  void addTag(Tag tag) {
    _selectTags.add(tag);
    notifyListeners();
  }

  void removeTag(Tag tag) {
    _selectTags.remove(tag);
    notifyListeners();
  }

  void addTopic(Topic topic) {}

  Future createTopic(context) async {
    if (_title == null || _title.length == 0) {
      showToast('请填写标题', context: context);
      return;
    }

    if (_selectSubject == null) {
      showToast('请选择文章主题', context: context);
      return;
    }

    if (_tags == null || _tags.length == 0) {
      showToast('请选择文章标签', context: context);
      return;
    }

    try {
      Topic topic = await repository.createTopic(
        title: _title,
        content: _content,
        contentType: _contentType,
        subjectId: _selectSubject.id,
        tagIds: _selectTags.map((e) => e.id).toList(),
        token: articleState.globalUser.token.accessToken,
      );
      addTopic(topic);
      return topic;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }
}
