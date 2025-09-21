import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/models/common/profile_type.dart';
import 'package:herbtrace_app/models/profiles/base_profile.dart';

final currentProfileProvider = StateProvider<BaseProfile?>((ref) => null);

final profileTypeProvider = StateProvider<ProfileType?>((ref) => null);
