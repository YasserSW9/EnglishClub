// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksResponse _$TasksResponseFromJson(Map<String, dynamic> json) =>
    TasksResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TasksResponseToJson(TasksResponse instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  done: json['done'] == null
      ? null
      : Done.fromJson(json['done'] as Map<String, dynamic>),
  waiting: (json['waiting'] as List<dynamic>?)
      ?.map((e) => Waiting.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'done': instance.done,
  'waiting': instance.waiting,
};

Done _$DoneFromJson(Map<String, dynamic> json) => Done(
  currentPage: (json['current_page'] as num?)?.toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => DoneData.fromJson(e as Map<String, dynamic>))
      .toList(),
  firstPageUrl: json['first_page_url'] as String?,
  from: (json['from'] as num?)?.toInt(),
  lastPage: (json['last_page'] as num?)?.toInt(),
  lastPageUrl: json['last_page_url'] as String?,
  links: (json['links'] as List<dynamic>?)
      ?.map((e) => Links.fromJson(e as Map<String, dynamic>))
      .toList(),
  nextPageUrl: json['next_page_url'] as String?,
  path: json['path'] as String?,
  perPage: (json['per_page'] as num?)?.toInt(),
  prevPageUrl: json['prev_page_url'] as String?,
  to: (json['to'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
);

Map<String, dynamic> _$DoneToJson(Done instance) => <String, dynamic>{
  'current_page': instance.currentPage,
  'data': instance.data,
  'first_page_url': instance.firstPageUrl,
  'from': instance.from,
  'last_page': instance.lastPage,
  'last_page_url': instance.lastPageUrl,
  'links': instance.links,
  'next_page_url': instance.nextPageUrl,
  'path': instance.path,
  'per_page': instance.perPage,
  'prev_page_url': instance.prevPageUrl,
  'to': instance.to,
  'total': instance.total,
};

DoneData _$DoneDataFromJson(Map<String, dynamic> json) => DoneData(
  id: (json['id'] as num?)?.toInt(),
  message: json['message'] as String?,
  requiredAction: json['required_action'] as String?,
  done: (json['done'] as num?)?.toInt(),
  issuedAt: json['issued_at'] as String?,
  doneAt: json['done_at'] as String?,
  adminId: (json['admin_id'] as num?)?.toInt(),
  storyId: (json['story_id'] as num?)?.toInt(),
  studentId: (json['student_id'] as num?)?.toInt(),
  doneByAdmin: json['done_by_admin'] == null
      ? null
      : DoneByAdmin.fromJson(json['done_by_admin'] as Map<String, dynamic>),
  unreturnedStory: json['unreturned_story'] == null
      ? null
      : UnreturnedStory.fromJson(
          json['unreturned_story'] as Map<String, dynamic>,
        ),
  student: json['student'] == null
      ? null
      : Student.fromJson(json['student'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DoneDataToJson(DoneData instance) => <String, dynamic>{
  'id': instance.id,
  'message': instance.message,
  'required_action': instance.requiredAction,
  'done': instance.done,
  'issued_at': instance.issuedAt,
  'done_at': instance.doneAt,
  'admin_id': instance.adminId,
  'story_id': instance.storyId,
  'student_id': instance.studentId,
  'done_by_admin': instance.doneByAdmin,
  'unreturned_story': instance.unreturnedStory,
  'student': instance.student,
};

DoneByAdmin _$DoneByAdminFromJson(Map<String, dynamic> json) => DoneByAdmin(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  superField: (json['super'] as num?)?.toInt(),
);

Map<String, dynamic> _$DoneByAdminToJson(DoneByAdmin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'super': instance.superField,
    };

UnreturnedStory _$UnreturnedStoryFromJson(Map<String, dynamic> json) =>
    UnreturnedStory(
      id: (json['id'] as num?)?.toInt(),
      qrCode: json['qrCode'] as String?,
      title: json['title'] as String?,
      blurb: json['blurb'] as String?,
      allowedBorrowDays: (json['allowed_borrow_days'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      coverUrl: json['cover_url'] as String?,
      subLevelId: (json['sub_level_id'] as num?)?.toInt(),
      testId: (json['test_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UnreturnedStoryToJson(UnreturnedStory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qrCode': instance.qrCode,
      'title': instance.title,
      'blurb': instance.blurb,
      'allowed_borrow_days': instance.allowedBorrowDays,
      'quantity': instance.quantity,
      'cover_url': instance.coverUrl,
      'sub_level_id': instance.subLevelId,
      'test_id': instance.testId,
    };

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  score: (json['score'] as num?)?.toInt(),
  goldenCoins: (json['golden_coins'] as num?)?.toInt(),
  silverCoins: (json['silver_coins'] as num?)?.toInt(),
  bronzeCoins: (json['bronze_coins'] as num?)?.toInt(),
  profilePicture: json['profile_picture'] as String?,
  inactive: json['inactive'] as String?,
  borrowLimit: (json['borrow_limit'] as num?)?.toInt(),
  gClassId: (json['g_class_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'score': instance.score,
  'golden_coins': instance.goldenCoins,
  'silver_coins': instance.silverCoins,
  'bronze_coins': instance.bronzeCoins,
  'profile_picture': instance.profilePicture,
  'inactive': instance.inactive,
  'borrow_limit': instance.borrowLimit,
  'g_class_id': instance.gClassId,
};

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
  url: json['url'] as String?,
  label: json['label'] as String?,
  active: json['active'] as bool?,
);

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
  'url': instance.url,
  'label': instance.label,
  'active': instance.active,
};

Waiting _$WaitingFromJson(Map<String, dynamic> json) => Waiting(
  id: (json['id'] as num?)?.toInt(),
  message: json['message'] as String?,
  requiredAction: json['required_action'] as String?,
  done: (json['done'] as num?)?.toInt(),
  issuedAt: json['issued_at'] as String?,
  doneAt: json['done_at'] as String?,
  adminId: (json['admin_id'] as num?)?.toInt(),
  storyId: (json['story_id'] as num?)?.toInt(),
  studentId: (json['student_id'] as num?)?.toInt(),
  unreturnedStory: json['unreturned_story'] == null
      ? null
      : UnreturnedStory.fromJson(
          json['unreturned_story'] as Map<String, dynamic>,
        ),
  student: json['student'] == null
      ? null
      : Student.fromJson(json['student'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WaitingToJson(Waiting instance) => <String, dynamic>{
  'id': instance.id,
  'message': instance.message,
  'required_action': instance.requiredAction,
  'done': instance.done,
  'issued_at': instance.issuedAt,
  'done_at': instance.doneAt,
  'admin_id': instance.adminId,
  'story_id': instance.storyId,
  'student_id': instance.studentId,
  'unreturned_story': instance.unreturnedStory,
  'student': instance.student,
};
