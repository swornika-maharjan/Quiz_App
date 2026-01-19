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

  final TextEditingController _nameController = TextEditingController();
  final _loginFormKey = GlobalKey<FormBuilderState>();

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
            automaticallyImplyLeading: false,
            title: Text(
              'Login',
              style: header2.copyWith(
                fontWeight: FontWeight.w700,
                color: QZColor.headerColor,
              ),
            ),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: _buildLoginContainer(),
          )
          // Column(
          //   children: [

          //     // Padding(
          //     //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          //     //   child: TabBar(
          //     //     labelPadding: EdgeInsets.zero,
          //     //     indicator: BoxDecoration(
          //     //       color: QZColor.headerColor,
          //     //       borderRadius: BorderRadius.circular(8),
          //     //     ),
          //     //     unselectedLabelColor: QZColor.headerColor,
          //     //     labelColor: QZColor.white,
          //     //     indicatorSize: TabBarIndicatorSize.tab,
          //     //     dividerColor: Colors.transparent,
          //     //     tabs: controller.tabs.map((tab) {
          //     //       return Tab(
          //     //         child: Container(
          //     //           alignment: Alignment.center,
          //     //           // margin: const EdgeInsets.symmetric(
          //     //           //   horizontal: 8,
          //     //           //   vertical: 8,
          //     //           // ),
          //     //           padding: const EdgeInsets.symmetric(vertical: 10),
          //     //           decoration: BoxDecoration(
          //     //             borderRadius: BorderRadius.circular(8),
          //     //             border: Border.all(color: QZColor.headerColor),
          //     //           ),
          //     //           child: Text(tab),
          //     //         ),
          //     //       );
          //     //     }).toList(),
          //     //   ),
          //     // ),
          //     // Expanded(
          //     //   child: TabBarView(
          //     //     children: [_buildLoginContainer(), _buildRegisterContainer()],
          //     //   ),
          //     // ),
          //   ],
          // ),
          ),
    );
  }

  Widget _buildLoginContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FormBuilder(
        key: _loginFormKey,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              textAlign: TextAlign.center,
              'Brain ready? Let’s gooo 🧠🔥',
              style: header2.copyWith(
                fontWeight: FontWeight.w700,
                color: QZColor.buttonColor,
              ),
            ),
            Text(
              'Login to start playing!😍',
              style: header3.copyWith(
                fontWeight: FontWeight.w600,
                color: QZColor.buttonColor,
              ),
            ),
            SizedBox(height: 30),
            Container(
              // height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: QZColor.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Email field
                  FormBuilderTextField(
                    controller: _emailController,
                    name: 'email',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        4,
                        errorText: 'Password must be 4 characters long!!',
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
                        if (_loginFormKey.currentState?.saveAndValidate() ??
                            false) {
                          controller.loginUser();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: QZColor.headerColor,
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
                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: header5.copyWith(
                          color: QZColor.headerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => RegisterScreen());
                        },
                        child: Text(
                          'Register here!',
                          style: header5.copyWith(
                            color: QZColor.color2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final LoginController controller = Get.find<LoginController>();
  final TextEditingController _registerPasswordController =
      TextEditingController();
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _registerFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Register',
          style: header4.copyWith(
            color: QZColor.headerColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom:
            PreferredSize(preferredSize: Size.fromHeight(1), child: Divider()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FormBuilder(
            key: _registerFormKey,
            child: Column(
              children: [
                SizedBox(height: 80),
                Text(
                  'Time to join the madness 😈🎉',
                  style: header3.copyWith(
                    color: QZColor.buttonColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Create account now 🚀',
                  style: header3.copyWith(
                    color: QZColor.buttonColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Enter your full Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        obscureText: false,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        obscureText: false,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            if (_registerFormKey.currentState
                                    ?.saveAndValidate() ??
                                false) {
                              controller.registerUser();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: QZColor.headerColor,
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: header5.copyWith(
                              color: QZColor.headerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => LoginScreen());
                            },
                            child: Text(
                              'Login here!',
                              style: header5.copyWith(
                                color: QZColor.color2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
