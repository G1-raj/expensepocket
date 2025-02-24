import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // Top Section
                Container(
                  color: Colors.deepPurpleAccent,
                  width: double.infinity,
                  height: screenHeight * 0.45, // 45% of screen height
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hi Govind",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.06, // Scales based on width
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "\$5000",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.12, // Scales dynamically
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Monthly salary",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Row for Actions
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildActionButton(Icons.analytics, "Analyze", screenWidth),
                            _buildActionButton(Icons.report_gmailerrorred, "Build report", screenWidth),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom Section
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenWidth * 0.04),
                      topRight: Radius.circular(screenWidth * 0.04),
                    ),
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text("Last 10 transactions", style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                            ),),
                          ),

                          Expanded(
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 3.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height * 0.12,
                                    color: Color.fromRGBO(103, 58, 183, 0.1),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Reusable method for buttons
  Widget _buildActionButton(IconData icon, String text, double screenWidth) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: screenWidth * 0.06),
          SizedBox(width: screenWidth * 0.02),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
