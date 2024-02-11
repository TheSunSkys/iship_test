- [x] Login screen 
- [x] Home screen
- [x] ใช้เพียง Stateless
- [x] มี state management (อะไรก็ได้) ถ้าเป็น BloC ได้ยิ่งดี 
- [x] เก็บข้อมูลลง storage (https://pub.dev/packages/hydrated_bloc)

### Requirement
1. สามารถ Login ได้
2. สามารถแสดงข้อมูล orders ได้
3. สามารถแชร์ไปยัง facebook ได้

   ใช้ `appinio_social_share` (https://pub.dev/packages/appinio_social_share) ในการแชร์ไปยัง facebook
4. สามารถแชร์หมายเลขพัสดุไปยังแอป 2 ได้

   ในส่วนนี้จะใช้ `deep linking` ในการแชร์ระหว่างแอพ โดย App A จะเปิด uri ผ่าน `url_launcher` (https://pub.dev/packages/url_launcher) แล้วให้ App B ดัก uri ที่ต้องการ ผ่าน `uni_links` (https://pub.dev/packages/uni_links) ที่ทำมาจะแบ่งเป็น 2 ส่วน คือ

   1. Android จะรองรับการทำ `deep linking` โดยที่ไม่จำเป็นต้องผ่านการยืนยันการเป็นเจ้าของเว็บ จากวิดีโอผมดักให้เปิดแอพเมื่อ uri เป็น `https://iship.co.th` ละดึง `track` มาแสดง
  
   2. IOS เนื่องจากการทำ `deep linking` ทางฝั่งนี้จะแบ่งเป็น 2 แบบ คือ `Universal Links(ผ่านการยืนยันการเป็นเจ้าของเว็บ เช่น https or http)` และ `Custom URL schemes([custom]://)` ผมเลยเลือกทำเป็น `Custom URL schemes` โดยจะเปิดจากแอพอืนแทนเพราะ `url_launcher` รองรับแค่ `https or http` ซึ่งถ้าเป็น `Universal Links` แล้วเปิดผ่าน `url_launcher` น่าจะใช้งานได้เหมือนกับฝั่น Android
6. สามารถแชร์ไปยัง Paperang ได้

    ใช้ `share_plus` (https://pub.dev/packages/share_plus) เพื่อแชร์ uri ไปให้ Peperang App
