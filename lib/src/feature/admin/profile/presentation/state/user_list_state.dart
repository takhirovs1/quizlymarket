import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../bloc/client/client_bloc.dart';
import '../screen/user_list_screen.dart';

abstract class UserListState extends State<UserListScreen> {
  late final ClientBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ClientBloc(repository: context.dependencies.repository.clientRepository);
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
