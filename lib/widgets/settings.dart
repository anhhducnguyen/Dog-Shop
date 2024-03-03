import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/theme_manager.dart';

class SettingsPage extends StatelessWidget {
  Color getLogoutButtonColor(BuildContext context, bool isDarkMode) {
  // return isDarkMode ? Colors.blue.shade400 : Theme.of(context).primaryColor;
   return isDarkMode ? Colors.grey.shade900 : Colors.white;
  }
  
  Color getTextColor(BuildContext context, bool isDarkMode) {
  // return isDarkMode ? Colors.blue.shade400 : Theme.of(context).primaryColor;
   return isDarkMode ? Colors.black: Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.themeMode == ThemeMode.dark;
    final fontSize = themeManager.fontSize;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
        backgroundColor: themeManager.appBarColor,
        // foregroundColor: Colors.white,
        foregroundColor: Colors.black,
        // foregroundColor: getTextColor(context, isDarkMode),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  // color: Colors.white,
                  // color: isDarkMode ? Colors.grey[900] : Colors.white,
                  color: getLogoutButtonColor(context, isDarkMode),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ListTile(
                      title: Text(
                        'Thông tin tài khoản',
                        style: TextStyle(fontSize: fontSize),
                      ),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[600],
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white, 
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right, 
                        color: Colors.grey[600],
                      ),
                      onTap: () {
                        Navigator.of(context).popAndPushNamed("/profile");
                      },
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      title: Text(
                        'Giới thiệu ứng dụng',
                        style: TextStyle(fontSize: fontSize),
                      ),
                      leading: Container(
                        width: 40,  
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[600],
                        ),
                        child: const Icon(
                          Icons.info_outline,
                          color: Colors.white, 
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right, 
                        color: Colors.grey[600],
                      ),
                      onTap: () {
                        Navigator.of(context).popAndPushNamed("/profile");
                      },
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      title: Text(
                        'Mật khẩu và bảo mật',
                        style: TextStyle(fontSize: fontSize),
                      ),
                      leading: Container(
                        width: 40,  // Adjust the size as needed
                        height: 40, // Adjust the size as needed
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue[600],
                        ),
                        child: const Icon(
                          Icons.lock,
                          color: Colors.white, // Icon color
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right, // Biểu tượng "greater than"
                        color: Colors.grey[600],
                      ),
                      onTap: () {
                        Navigator.of(context).popAndPushNamed("/");
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),
        
              // table 2
              Container(
                decoration: BoxDecoration(
                  // color: Colors.white,
                  color: getLogoutButtonColor(context, isDarkMode),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple[600],
                  ),
                  child: const Icon(
                    Icons.nightlight,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right, 
                  color: Colors.grey[600],
                ),
                title: Text(
                  'Chế độ nền tối',
                  style: TextStyle(fontSize: fontSize),
                ),
                onTap: () {
                  _showDarkModePicker(context, themeManager);
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pink[600],
                  ),
                  child: const Icon(
                    Icons.color_lens,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right, 
                  color: Colors.grey[600],
                ),
                title: Text(
                  'Giao diện',
                  style: TextStyle(fontSize: fontSize),
                ),
                onTap: () {
                  _showAppBarPicker(context, themeManager);
                },
              ),
              const SizedBox(height: 10),
              // table 3
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange[600],
                  ),
                  child: const Icon(
                    Icons.text_format_sharp,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right, 
                  color: Colors.grey[600],
                ),
                title: Text(
                  'Kích thước chữ',
                  style: TextStyle(fontSize: fontSize),
                ),
                onTap: () {
                  _showFontSizePicker(context, themeManager);
                },
              ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  // color: Colors.white,
                  color: getLogoutButtonColor(context, isDarkMode),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ListTile(
                      title: Text(
                        'Ngôn ngữ',
                        style: TextStyle(fontSize: fontSize),
                      ),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue[600],
                        ),
                        child: const Icon(
                          Icons.language,
                          color: Colors.white, 
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right, 
                        color: Colors.grey[600],
                      ),
                      onTap: () {
                        Navigator.of(context).popAndPushNamed("/profile");
                      },
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                title: Text(
                  'Xóa tài khoản',
                  style: TextStyle(fontSize: fontSize),
                ),
                leading: Container(
                  width: 40,  
                  height: 40, 
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red[600],
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white, 
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right, 
                  color: Colors.grey[600],
                ),
                onTap: () {
                  Navigator.of(context).popAndPushNamed("/");
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text(
                  'Đăng xuất',
                  style: TextStyle(fontSize: fontSize),
                ),
                leading: Container(
                  width: 40,  
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[600],
                  ),
                  child: const Icon(
                    Icons.login_outlined,
                    color: Colors.white, // Icon color
                  ),
                ),
                onTap: () {
                  Navigator.of(context).popAndPushNamed("/");
                },
              ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

void _showFontSizePicker(BuildContext context, ThemeManager themeManager) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 300,
        child: Column(
          children: [
            const ListTile(
              title: Text('Kích thước chữ'),
            ),
            Expanded(
              child: ListView(
                children: ThemeManager.listFontSize
                    .map((size) => ListTile(
                          title: Row(
                            children: [
                              Text(size),
                              const Spacer(),  
                              if (themeManager.selectedFontSize == size)
                                Icon(Icons.check, color: Colors.blue[600]),
                            ],
                          ),
                          onTap: () {
                            themeManager.selectedFontSize = size;  
                            themeManager.fontSize = size;
                            Navigator.of(context).pop();
                          },
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      );
    },
  );
}

  void _showAppBarPicker(BuildContext context, ThemeManager themeManager) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: Column(
            children: [
              const ListTile(
                title: Text('Giao diện'),
              ),
              Expanded(
                child: ListView(
                  children: ThemeManager.listColorAppBar
                      .map((color) => ListTile(
                            title: Row(
                              children: [
                                Text(color),
                                Spacer(), 
                                if (themeManager.selectedAppBar == color)
                                  Icon(Icons.check, color: Colors.blue[600]),
                              ],
                            ),
                            onTap: () {
                              themeManager.selectedAppBar = color;  
                              themeManager.appBarColor = color;
                              Navigator.of(context).pop();
                            },
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDarkModePicker(BuildContext context, ThemeManager themeManager) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 180,
          child: Column(
            children: [
              const ListTile(
                title: Text('Chế độ nền tối'),
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text('Bật'),
                    const Spacer(),
                    if (themeManager.isDarkMode)
                      Icon(Icons.check, color: Colors.blue[600]),
                  ],
                ),
                onTap: () {
                  themeManager.toggleTheme(true);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    const Text('Tắt'),
                    const Spacer(),
                    if (!themeManager.isDarkMode)
                      Icon(Icons.check, color: Colors.blue[600]),
                  ],
                ),
                onTap: () {
                  themeManager.toggleTheme(false);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
