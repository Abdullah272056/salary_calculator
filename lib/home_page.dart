import 'dart:convert';
import 'dart:io';



import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:salary_calculator/static/Colors.dart';
import 'package:salary_calculator/static/gradiant_text.dart';

import 'model/experience_model.dart';
import 'model/tag_model_class.dart';






class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final List<ExperienceModel> _data = [
    ExperienceModel("1","0 year"),
    ExperienceModel("2","0+ year"),
    ExperienceModel("3","1 year"),
    ExperienceModel("4","1+ year"),
    ExperienceModel("5","2 years"),
    ExperienceModel("6","2+ years"),
    ExperienceModel("7","3 years"),
    ExperienceModel("8","3+ years"),
  ];
  List<TagModelClass> tagList=[];

  String _selectExperience="";
   int _selectExperienceIndex=-1;

  final TextEditingController? _skillNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Image.asset(
                //   "assets/images/aws.png",
                //   width: 160,
                //   height: 80,
                // ),

                Expanded(child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      GradientText(
                        'Calculate Your\nNearby Salary',
                        style: const TextStyle(fontSize: 35,fontWeight: FontWeight.w600,

                        ),
                        textAlign: TextAlign.center,
                        gradient: LinearGradient(colors: [
                          awsStartColor,
                          awsEndColor
                        ]),
                      ),
                      const SizedBox(
                        height: 120,
                      ),

                      userInputName(_skillNameController!, 'Skill Name',
                          TextInputType.text, "assets/images/icon_user.png"),

                      userInputSelectTopic(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Wrap(
                            children: [
                              _buildAddButton()
                            ],
                          )
                        ],
                      ),


                      if(tagList.isNotEmpty)...{

                        DelayedWidget(

                          delayDuration: const Duration(milliseconds: 100),// Not required
                          animationDuration: const Duration(milliseconds: 1000),// Not required
                          animation: DelayedAnimations.SLIDE_FROM_TOP,// Not required
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              // tagList
                              Stack(
                                children: [



                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                    padding: EdgeInsets.only(top: 20,bottom: 10,left: 10,right: 10),
                                    decoration: BoxDecoration(
                                      border: const GradientBoxBorder(
                                        gradient: LinearGradient(colors: [awsStartColor, awsEndColor]),
                                        width: 1,
                                      ),

                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Align(alignment: Alignment.topLeft,
                                          child: dynamicChips(),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Positioned(
                                    left: 30,
                                    top: 12,
                                    child:  Container(
                                      padding: const EdgeInsets.only(
                                          left: 10,bottom: 0,right: 10,top: 0
                                      ),
                                      color: Colors.white,

                                      child: Text("Your All Skill",
                                        style: TextStyle(
                                            color: awsMixedColor,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ),




                                ],
                              ),



                            ],
                          ),
                        ),

                      },
                      const SizedBox(
                        height: 20,
                      ),
                      _buildCalculateButton(),

                      const SizedBox(
                        height: 30,
                      ),
                      Row(children: [
                        Text("Your nearby salary is = ",
                          style: TextStyle(
                              fontSize: 20,
                              color: awsEndColor,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Text("0.00Bdt",
                          style: TextStyle(
                              fontSize: 20,
                              color: awsStartColor,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],)

                    ],
                  ),
                )),




              ],
            ),
          ),


        ),
      ),
    );
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("AppLifecycleState changed: $state");
    if (state == AppLifecycleState.resumed) {
      _showToast("resumed");
    }
  }

  int selectedIndex=0;
  // List<String> _dynamicChips = ['Python', 'Java', 'C++','Dart', 'Php', 'React'];
//  List<String> _dynamicChips = ['Python', 'Java', 'C++','Dart', 'Php', 'React'];

  dynamicChips() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 7.0,
      children: List<Widget>.generate(tagList.length, (int index) {
        return Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.red[500],
                  // ),
                gradient: LinearGradient(colors: [awsStartColor,awsEndColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                color:awsMixedColor,
              ),
              padding: EdgeInsets.only(left: 15,right: 10,top: 10,bottom: 10),

              child:InkWell(
                onTap: (){
                  setState((){

                    selectedIndex=index;
                  });

                },
                child:  Wrap(
                  direction: Axis.horizontal,

                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 2),
                      child: Text(tagList[index].tagName +" ("+ tagList[index].experienceYear+")",
                        style: const TextStyle(color: Colors.white, fontSize: 12,
                        fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    SizedBox(width: 8,),
                    InkWell(
                      onTap: (){
                        setState((){
                          tagList.removeAt(index);
                        });
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );


      }),
    );
  }


  Widget userInputName(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType, String icon_link) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color:ig_inputBoxBackGroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding:
        const EdgeInsets.only(left: 25.0, top: 0, bottom: 0, right: 20),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor:intello_text_color,
          style: TextStyle(
              color:intello_text_color
          ),
          autofocus: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            // suffixIcon: Icon(icons,color: Colors.hint_color,),

            suffixIconConstraints: const BoxConstraints(

              minHeight: 8,
              minWidth: 8,
            ),
            // suffixIcon: Image(
            //   color:icon_color_for_light,
            //   image: AssetImage(
            //
            //     icon_link,
            //   ),
            //   height: 17,
            //   width: 17,
            //   fit: BoxFit.fill,
            // ),

            hintText: hintTitle,
            hintStyle: TextStyle(
                fontSize: 16, color: hint_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }


  Widget userInputSelectTopic() {
    return Container(
        height: 55,

        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 00,right:00,top: 5,bottom: 15,),

        decoration: BoxDecoration(
            // color:search_send_money_box_color,
            color:ig_inputBoxBackGroundColor,
          //  color:Colors.hint_color,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(child: DropdownButton2(


              //   menuMaxHeight:55,
              value: _selectExperience != null && _selectExperience.isNotEmpty ? _selectExperience : null,
              underline:const SizedBox.shrink(),
              hint:Row(
                children: const [
                  SizedBox(width: 20,),
                  Text("Select Your Topic",
                      style: TextStyle(
                          color: hint_color,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                ],
              ),
              isExpanded: true,

              /// icon: SizedBox.shrink(),
              buttonPadding: const EdgeInsets.only(left: 0, right: 14),

              items:
              _data.map((list) {
                return DropdownMenuItem(



                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      const SizedBox(width: 20,),
                      Expanded(child: Text(
                          list.experienceYear.toString(),
                          style:  TextStyle(
                              color: Colors.black,
                              //color: intello_text_color,
                              fontSize: 18,
                              fontWeight: FontWeight.normal)),),


                      const SizedBox(width: 20,),

                    ],
                  ),

                  // Text(list["country_name"].toString()),
                  value: list.experienceYearId.toString(),
                 // value: list.id.toString(),
                );

              },
              ).toList(),
              onChanged: (String? value) {
                //_getCountryDataList1();
                setState((){
                  _selectExperience=value.toString();
                  //selected index
                  final int index1 = _data.indexWhere(((experienceList) => experienceList.experienceYearId == value));
                  _selectExperienceIndex=index1;
                  // _showToast(index1.toString());
                });

              },

            ),)
          ],
        )
    );
  }

  Widget _buildAddButton() {
    return InkWell(
      onTap: () {

        String skillNameTxt = _skillNameController!.text;

        if(skillNameTxt.isEmpty){

       //   _showToast("please enter skill name");
          createSnackBar("Please enter skill name!");
         return;
        }
        if(_selectExperienceIndex<0){
         // _showToast("please select experience years");
          createSnackBar("Please select experience years!");
          return;
        }

        setState((){
          tagList.add(TagModelClass("1", skillNameTxt,_data[_selectExperienceIndex].experienceYearId,
              _data[_selectExperienceIndex].experienceYear));
          _skillNameController!.text="";
          _selectExperience="";
          _selectExperienceIndex=-1;



          //_showToast(tagList.length.toString());

        });

      },

      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [awsStartColor, awsEndColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(7.0)
        ),
        child: Container(
          padding: EdgeInsets.only(left: 25,right: 25),

          height: 45,
          alignment: Alignment.center,
          child:  Text(
            "Add Skill",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalculateButton() {
    return InkWell(
      onTap: () {


      },

      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [awsStartColor, awsEndColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(7.0)
        ),
        child: Container(
          padding: EdgeInsets.only(left: 25,right: 25),

          height: 50,
          alignment: Alignment.center,
          child:  const Text(
            "Calculate Salary",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }



  void createSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      content:  Text(message,style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal

      ),),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
        topLeft:Radius.circular(5.0),
        topRight:Radius.circular(5.0)

        ,)),
      backgroundColor: Colors.deepOrange,
       duration: Duration(seconds: 2, milliseconds: 500),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }


  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:awsMixedColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

}


