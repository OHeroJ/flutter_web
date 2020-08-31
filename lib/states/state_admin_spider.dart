import 'package:flutter/cupertino.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/model/model.dart';
import 'package:flutter_web/services/services.dart';
import 'package:flutter_web/states/global_user_state.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oktoast/oktoast.dart';

class StateAdminSpider extends ViewStateModel {
  final GlobalUserState globalUser;
  StateAdminSpider({@required this.globalUser});

  List<SpiderTopic> _topics = [];

  List<SpiderTopic> get topics => _topics;

  final repository = locator<SpiderRepository>();
  final apiRepository = locator<WebRepository>();

  String _title;
  String _content;
  String _remarks;
  String _url;
  String _source;

  uploadTopic(SpiderTopic topic) {
    title = topic.title;
    content = topic.detail;
    remarks = topic.desc;
    url = topic.url;
    source = topic.source;
  }

  set title(String title) {
    _title = title;
  }

  set content(String content) {
    _content = content;
  }

  set remarks(String remarks) {
    _remarks = remarks;
  }

  set url(String url) {
    _url = url;
  }

  set source(String source) {
    _source = source;
  }

  upload(SpiderTopic topic, context) async {
    Topic result = await apiRepository.createTopic(
      title: _title,
      content: _content,
      contentType: topicContentTypeToString(TopicContentType.html),
      subjectId: "33A08217-88E9-4D2E-81D8-04DD145C70FE", // 新闻 subject
      tagIds: ["10694446-910B-4E99-8F0D-0B69ED07119D"], // 新闻tag
      token: globalUser.token.accessToken,
      remarks: _remarks,
      url: _url,
      source: _source,
    );

    showToast('上传成功', context: context);
    _topicUploaded(topic);
    return result;
  }

  _topicUploaded(SpiderTopic topic) async {
    Map res = await repository.updateUploadState(topic.id);
    topic.isUpload = true;
    notifyListeners();
  }

  loadTopics() async {
    setBusy();
    try {
      _topics = await repository.getNewsList();
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  refreshSpider() async {
    Map result = await repository.refreshSpider();
    return result;
  }
}
