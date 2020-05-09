import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine/models/models.dart';
import 'package:sunshine/services/services.dart';
import 'package:sunshine/sunshine.dart';

class AccountDetailsForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _firstNameNode = FocusNode();
  final _lastNameNode = FocusNode();
  final _passwordNode = FocusNode();
  final _confirmPasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final accountDetailsService = context.watch<AccountDetailsService>();
    final details = context.watch<AccountDetails>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 13.h.toDouble()),
          Text(
            'Account details',
            style: TextStyle(fontSize: 36.ssp.toDouble()),
          ),
          SizedBox(height: 42.h.toDouble()),
          Form(
            key: _formKey,
            autovalidate: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Input(
                  hintText: 'First Name',
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_lastNameNode);
                  },
                  onFieldSubmitted: (v) {
                    accountDetailsService.update(
                      details.copyWith(firstName: v),
                    );
                  },
                  validator: (v) {
                    if (v.trim().isEmpty) {
                      return 'first name cannont be empty!';
                    } else {
                      return null;
                    }
                  },
                  focusNode: _firstNameNode,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 16.h.toDouble()),
                Input(
                  hintText: 'Last Name',
                  focusNode: _lastNameNode,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                  onFieldSubmitted: (v) {
                    accountDetailsService.update(
                      details.copyWith(lastName: v),
                    );
                  },
                  validator: (v) {
                    if (v.trim().isEmpty) {
                      return 'last name cannont be empty!';
                    } else {
                      return null;
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 16.h.toDouble()),
                Input(
                  hintText: 'Password',
                  focusNode: _passwordNode,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_confirmPasswordNode);
                  },
                  onChanged: (v) {
                    accountDetailsService.update(
                      details.copyWith(password: v),
                    );
                  },
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Password cannot be empty!';
                    } else if (v.length < 8) {
                      return 'password must be at least 8 characters long';
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                ),
                SizedBox(height: 16.h.toDouble()),
                Input(
                  hintText: 'Confirm Password',
                  focusNode: _confirmPasswordNode,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  validator: (v) {
                    if (v != details?.password) {
                      return 'Passwords dose not match!';
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
