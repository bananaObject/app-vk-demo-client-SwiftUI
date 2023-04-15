# VK Client (SwiftUI)
Демоверсия мобильного приложения "клиента Вконтакте". 

<h2>Оглавление</h2>

1. [Скриншоты](#%D1%81%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82%D1%8B)
2. [Демо видео](#%D0%B4%D0%B5%D0%BC%D0%BE-%D0%B2%D0%B8%D0%B4%D0%B5%D0%BE)
3. [Описание](#%D0%BE%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5)
4. [Технологии](#%D1%82%D0%B5%D1%85%D0%BD%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D0%B8)

<div>  
<h2>Скриншоты</h2>
<img height="700" src="https://user-images.githubusercontent.com/75171952/227711989-61ea0d97-8b6c-4a04-96e9-adc856675a37.png">
<img height="700" src="https://user-images.githubusercontent.com/75171952/227711997-160307bb-63e4-4ec5-aa86-08f48b1aec33.png">
<img height="700" src="https://user-images.githubusercontent.com/75171952/227712001-5f1816c3-b27f-43e2-8bb6-6514d2f93e23.png">
<img height="700" src="https://user-images.githubusercontent.com/75171952/227712002-aef0c23f-8a6a-4430-b58f-1c18c36cc541.png">
<img height="700" src="https://user-images.githubusercontent.com/75171952/227712003-d78df8e1-3aa8-4eed-b2ef-6a63cfbe8122.png">

<h2>Демо видео</h2>
<details>
  <summary><h2>Видео (Кликнуть, чтоб увидеть)</h2></summary>
  
  Авторизация  | Выход из профиля
  :-: | :-:
  <video src='https://user-images.githubusercontent.com/75171952/227712096-93c60832-e46e-4f34-9f6a-7d7921ffe3bd.mov'/>  | <video src='https://user-images.githubusercontent.com/75171952/227712122-9eba5a7b-0fde-4f1e-8ed2-dbcb416a5291.mov'/>

  Список друзей | Удаление друга
  :-: | :-:
  <video src='https://user-images.githubusercontent.com/75171952/227712148-f4ab3684-609e-46ce-a33e-147d3fee663c.mov'/> |  <video src='https://user-images.githubusercontent.com/75171952/227712167-84ab475f-c9bf-49e7-a120-7bb6f14ffa2e.mov'/> 

  Коллекция фотографий друга | 
  :-: | 
  <video src='https://user-images.githubusercontent.com/75171952/227712232-d9cecff4-0185-49fc-9eb3-d4cd8ca33fdb.mov'/> |
  </details>
</div>

## Описание

**Демоверсия мобильного приложения** для социальной сети ВКонтакте **разработана с использованием SwiftUI** и поддерживает **iOS 13 и выше**. 
Для решения проблем несовершенств SwiftUI на iOS 13 **используется UIViewRepresentable и UIHostingController**.

**Реализованы принципы программирования с протоколами (POP) и Dependency Injection (DI)** для более гибкой и расширяемой архитектуры приложения.

В приложении были **добавлены AppDelegate и SceneDelegate**. Также **используется паттерн Coordinator** для управления навигацией и координацией. 

**Используется реактивное программирование Combine** + **архитектура MVVM**. 

**[Сетевой слой](vkSwiftUI/Support/Layers/Api) был реализован с использованием дженериков и расширений** для обеспечения легкого расширения и масштабирования его работы. 

Для загрузки изображений был **написан свой [ImageLoader](vkSwiftUI/Support/Layers/ImageLoader.swift)**. 
Для фотографии друга доступна опция «Нравится». 
> Если происходит множественное изменение состояния лайка на одном фото в короткий промежуток времени, то такие изменения обрабатываются через дебоунс оператор и отправляются на сервер как один запрос.

Для хранения информации о друзьях **используется база данных Core Data**. 
Для авторизации пользователя **используется веб-вью**, а токен авторизации **сохраняется в защищенном пространстве Keychain**. 

Так как это демоверсия, то в приложении реализован только следующий функционал: 
- авторизация 
- выход из профиля 
- список друзей 
- удаление друга 
- коллекция фотографий друга

# Технологии
* Swift
* SwiftUI 
* UIKit(UIHostingController + UIViewRepresentable)
* MVVM + Coordinator
* POP + DI
* Combine
* Async/await
* URLSession
* CoreData
* Webkit
* Keychain
