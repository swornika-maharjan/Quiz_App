import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:quizzie/features/auth/controllers/login_controller.dart';
import 'package:quizzie/utils/colors.dart';
import 'package:quizzie/utils/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _registerPasswordController =
      TextEditingController();
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TabBar(
                labelPadding: EdgeInsets.zero,
                indicator: BoxDecoration(
                  color: Colors.purple[200], // active tab color
                  borderRadius: BorderRadius.circular(8),
                ),
                unselectedLabelColor: Colors.purple[400],
                labelColor: QZColor.white,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: controller.tabs.map((tab) {
                  return Tab(
                    child: Container(
                      alignment: Alignment.center,
                      // margin: const EdgeInsets.symmetric(
                      //   horizontal: 8,
                      //   vertical: 8,
                      // ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.purple.shade200),
                      ),
                      child: Text(tab),
                    ),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [_buildLoginContainer(), _buildRegisterContainer()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FormBuilder(
        key: controller.loginFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.center,
              'Quizzie \n Time to test your knowledge!🧠',
              style: header2.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.purple[400],
              ),
            ),
            Text(
              'Login to start playing!😍',
              style: header3.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.purple[400],
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: QZColor.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email field
                  FormBuilderTextField(
                    controller: _emailController,
                    name: 'email',
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'email is required!!',
                      ),
                      FormBuilderValidators.email(
                        errorText: 'Please enter a valid email!',
                      ),
                    ]),
                    onChanged: (value) {
                      controller.updateFormData('email', value);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  FormBuilderTextField(
                    name: 'password',
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Password is required!!',
                      ),
                    ]),
                    onChanged: (value) {
                      controller.updateFormData('password', value);
                    },
                  ),
                  const SizedBox(height: 24),

                  // Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.loginFormKey.currentState
                                ?.saveAndValidate() ??
                            false) {
                          controller.loginUser();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[200],
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: header5.copyWith(
                          color: QZColor.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterContainer() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.registerFormKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: QZColor.grey),
                ),
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'Enter your full Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      obscureText: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Name is required!!',
                        ),
                      ]),
                      onChanged: (value) {
                        controller.updateFormData('name', value);
                      },
                    ),
                    SizedBox(height: 15),
                    FormBuilderTextField(
                      name: 'email',
                      controller: _registerEmailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      obscureText: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Email is required!!',
                        ),
                        FormBuilderValidators.email(
                          errorText: 'Enter a valid email address!',
                        ),
                      ]),
                      onChanged: (value) {
                        controller.updateFormData('email', value);
                      },
                    ),

                    SizedBox(height: 15),
                    FormBuilderTextField(
                      name: 'password',
                      controller: _registerPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      obscureText: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Password is required!!',
                        ),
                        FormBuilderValidators.maxLength(
                          6,
                          errorText: 'Password must be 6 characters long!!',
                        ),
                      ]),
                      onChanged: (value) {
                        controller.updateFormData('password', value);
                      },
                    ),

                    const SizedBox(height: 24),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.registerFormKey.currentState
                                  ?.saveAndValidate() ??
                              false) {
                            controller.registerUser();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[200],
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: header5.copyWith(
                            color: QZColor.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
