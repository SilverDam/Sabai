import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import 'base.dart';
import 'onboarding.dart';

class SignScreen extends StatefulWidget {
  const SignScreen();

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  bool isSignUp = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

// signup user fnction
    void signUpUser() async {
      FirebaseAuthMethods(FirebaseAuth.instance).signUpwithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context
          
          
          ).then((value) {
                
                if(FirebaseAuth.instance.currentUser!.emailVerified) {

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const  BaseScreen()));
                }

          });
    }


//login user function


 void loginUser() async {
      FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmaiAndPassword(
          email: emailController.text,
          password: passwordController.text,
          context: context
          
          
          );
         
    }



    @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

  

    return Scaffold(body: isSignUp ? signIn() : signUp());
  }

  Widget signIn() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 60, right: 30, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: isSignUp == true ? 'Sign In your\n' : 'Create a new\n',
                  style: Theme.of(context).textTheme.titleLarge,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Kimiko',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: ' account',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Container(
                    height: height * 0.055,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                      // Email input
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Theme.of(context).colorScheme.onSurface,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(decoration: TextDecoration.none),
                        decoration: InputDecoration(
                          focusColor: Theme.of(context).colorScheme.onSurface,
                          contentPadding:
                              const EdgeInsets.only(left: 18.0, right: 18),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                          labelText: 'Email',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                          suffixIcon: Icon(Icons.mail_outline_rounded,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  //Password input
                  Container(
                    height: height * 0.055,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                      // password
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: Theme.of(context).colorScheme.onSurface,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(decoration: TextDecoration.none),
                        decoration: InputDecoration(
                          focusColor: Theme.of(context).colorScheme.onSurface,
                          contentPadding:
                              const EdgeInsets.only(left: 18.0, right: 18),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                          labelText: 'Password',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                          suffixIcon: Icon(Icons.password_rounded,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  GestureDetector(
                    
                    onTap:  loginUser,
                    child: button(context, height, width, 'Sign in')),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSignUp = false;
                      });
                         emailController.clear();
                      passwordController.clear();
                     
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don’t have an account?',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: <TextSpan>[
                          TextSpan(
                            text: ' Sign up',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 1,
                        color: Theme.of(context).colorScheme.onSurface,
                        width: width * 0.3,
                      ),
                      Text(
                        'Sign in with',
                        style:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(),
                      ),
                      Container(
                        height: 1,
                        color: Theme.of(context).colorScheme.onSurface,
                        width: width * 0.3,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'asset/images/google.png',
                        height: 30,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Image.asset(
                        'asset/images/apple.png',
                        height: 30,
                      ),
                      const SizedBox(width: 40),
                      Image.asset(
                        'asset/images/wechat.png',
                        height: 30,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget signUp() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 60, right: 30, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Create a new\n',
                  style: Theme.of(context).textTheme.titleLarge,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Kimiko',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: ' account',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Container(
                    height: height * 0.055,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                      // Email input
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Theme.of(context).colorScheme.onSurface,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(decoration: TextDecoration.none),
                        decoration: InputDecoration(
                          focusColor: Theme.of(context).colorScheme.onSurface,
                          contentPadding:
                              const EdgeInsets.only(left: 18.0, right: 18),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                          labelText: 'Email',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                          suffixIcon: Icon(Icons.mail_outline_rounded,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  //Password input
                  Container(
                    height: height * 0.055,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                      //password
                      child: TextFormField(
                           obscureText: true,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: Theme.of(context).colorScheme.onSurface,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(decoration: TextDecoration.none),
                        decoration: InputDecoration(
                          focusColor: Theme.of(context).colorScheme.onSurface,
                          contentPadding:
                              const EdgeInsets.only(left: 18.0, right: 18),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                          labelText: 'Password',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                          suffixIcon: Icon(Icons.password_rounded,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //Confirm password

                  Container(
                    height: height * 0.055,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                      // Email input
                      child: TextFormField(
                           obscureText: true,
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: Theme.of(context).colorScheme.onSurface,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(decoration: TextDecoration.none),
                        decoration: InputDecoration(
                          focusColor: Theme.of(context).colorScheme.onSurface,
                          contentPadding:
                              const EdgeInsets.only(left: 18.0, right: 18),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                          labelText: 'Confirm password',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                          suffixIcon: Icon(Icons.password_rounded,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  GestureDetector(
                    
                    onTap: signUpUser,
                    child: button(context, height, width, 'Create account')),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setState(() {
                          isSignUp = true;
                        });
                        emailController.clear();

                        passwordController.clear();
                        confirmPasswordController.clear();
                      });
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an accout?',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: <TextSpan>[
                          TextSpan(
                            text: ' Login',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 1,
                        color: Theme.of(context).colorScheme.onSurface,
                        width: width * 0.3,
                      ),
                      Text(
                        'Sign up with',
                        style:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(),
                      ),
                      Container(
                        height: 1,
                        color: Theme.of(context).colorScheme.onSurface,
                        width: width * 0.3,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'asset/images/google.png',
                        height: 30,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Image.asset(
                        'asset/images/apple.png',
                        height: 30,
                      ),
                      const SizedBox(width: 40),
                      Image.asset(
                        'asset/images/wechat.png',
                        height: 30,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
