import 'package:pet_community/util/tools.dart';

class PrivacyPolicyView extends StatefulWidget {
  static const String routeName = "PrivacyPolicyView";

  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("用户协议及隐私政策")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
              child: const Text(""" 
**1. 协议前言**
                
        本协议旨在明确用户使用本APP所应遵守的各项规定，保障用户权益，维护服务秩序。用户在注册、使用本APP前，应认真阅读本协议，并完全理解和同意本协议的所有内容。用户一旦注册、使用本APP，即视为接受本协议的约束。
                
**2. 服务内容**
                
        本APP提供的服务包括但不限于信息展示、互动交流、在线交易等。具体服务内容以APP实际提供为准。
                
**3. 用户权益**
                
        用户有权在遵守本协议的前提下使用本APP提供的各项服务。用户有权享有本APP提供的合法、合规的服务内容。
                
**4. 用户义务**
                
        用户应遵守国家法律法规，不得利用本APP进行任何违法、违规活动。用户应维护APP的秩序，不得发布虚假信息、恶意攻击他人或进行其他不当行为。
                
**5. 知识产权保护**
                
        本APP提供的所有内容受著作权法、商标法、专利法等法律法规的保护。用户在使用本APP时，不得侵犯任何第三方的知识产权。
                
**6. 免责声明**
                
        因网络故障、系统维护、第三方行为等非本APP所能控制的原因导致用户无法正常使用本APP服务的，本APP不承担任何责任。
                
**7. 隐私保护政策**
                
        本APP高度重视用户隐私保护，制定并执行严格的隐私保护政策。用户的个人信息将受到严格保密，不会被泄露给任何无关第三方。
                
**8. 数据收集与使用**
                
        为了提供更好的服务，本APP可能会收集用户的一些基本信息和使用数据。这些数据将仅用于统计分析、优化服务和提升用户体验，不会用于其他无关目的。
                
**9. 数据共享与转让**
                
        除法律法规另有规定外，本APP不会将用户的个人信息共享给第三方，也不会将其转让给任何无关第三方。
                
**10. 数据安全与保护**
                
        本APP将采取合理的技术和管理措施，保障用户数据的安全性和保密性，防止数据被非法获取、篡改或丢失。
                
**11. 用户权利与选择**
                
        用户有权查看、更正和删除自己的个人信息。用户也有权选择关闭个性化推荐等功能。
                
**12. 未成年人保护**
                
        本APP将加强对未成年人的保护，限制其访问和使用某些可能对其造成不良影响的内容。
                
**13. 协议变更与终止**
                
        本协议可能会因法律法规变化、服务升级等原因而变更。用户如不接受新的协议，可以选择停止使用本APP。
                
**14. 法律适用与争议解决**
                
        本协议的签订、履行、解释及争议解决均适用中华人民共和国法律。如发生争议，双方应友好协商解决；协商不成的，任何一方均有权向有管辖权的人民法院提起诉讼。
                
        用户在注册、使用本APP前，应认真阅读本协议，并完全理解和同意本协议的所有内容。用户一旦注册、使用本APP，即视为接受本协议的约束。
            """),
            )
          ],
        ),
      ),
    );
  }
}
