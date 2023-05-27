import 'package:genibook/models/schedule_class.dart';
import 'package:genibook/models/student_class.dart';

Map<String, dynamic> emptySecretDict = {
  "username": "",
  "password": "",
  "user": "1",
  "mp": "",
  "highschool": ""
};

Map<String, List<Map<String, dynamic>>> assignments = {
  "Math": [
    {
      "course_name": "Math",
      "mp": "3",
      "dayname": "Mon",
      "full_dayname": "Monday",
      "date": "12/20",
      "full_date": "12/20/2021",
      "teacher": "Mr. Smith",
      "category": "Homework",
      "assignment": "Page 40-41, problems 1-10",
      "description": "Complete the assigned problems in your workbook.",
      "grade_percent": "90",
      "grade_num": "9/10",
      "comment": "Great job! Just missed one question.",
      "prev": "N/A",
      "docs": "N/A"
    }
  ],
  "Science": [
    {
      "course_name": "Science",
      "mp": "3",
      "dayname": "Tus",
      "full_dayname": "Tuesday",
      "date": "12/21",
      "full_date": "12/21/2021",
      "teacher": "Ms. Johnson",
      "category": "Lab Report",
      "assignment": "Experiment 4: Chemical Reactions",
      "description":
          "Write a lab report summarizing the results of the experiment.",
      "grade_percent": "95",
      "grade_num": "19/20",
      "comment": "Excellent work! You just missed a few minor details.",
      "prev": "N/A",
      "docs": "N/A"
    },
    {
      "course_name": "Science",
      "mp": "3",
      "dayname": "Wed",
      "full_dayname": "Wednesday",
      "date": "12/24",
      "full_date": "12/24/2021",
      "teacher": "Ms. Johnson",
      "category": "Lab Report",
      "assignment": "Experiment 4: Chemical Reactions",
      "description":
          "Write a lab report summarizing the results of the experiment.",
      "grade_percent": "95",
      "grade_num": "19/20",
      "comment": "Excellent work! You just missed a few minor details.",
      "prev": "N/A",
      "docs": "N/A"
    },
    {
      "course_name": "Science",
      "mp": "3",
      "dayname": "Thus",
      "full_dayname": "Thursday",
      "date": "12/25",
      "full_date": "12/25/2021",
      "teacher": "Ms. Johnson",
      "category": "Lab Report",
      "assignment": "Experiment 4: Chemical Reactions",
      "description":
          "Write a lab report summarizing the results of the experiment.",
      "grade_percent": "95",
      "grade_num": "19/20",
      "comment": "Excellent work! You just missed a few minor details.",
      "prev": "N/A",
      "docs": "N/A"
    }
  ],
  "English": [
    {
      "course_name": "English",
      "mp": "3",
      "dayname": "Wed",
      "full_dayname": "Wednesday",
      "date": "12/22",
      "full_date": "12/22",
      "teacher": "Ms. Lee",
      "category": "Essay",
      "assignment": "Persuasive Essay",
      "description": "Write a persuasive essay on the topic given in class.",
      "grade_percent": "85",
      "grade_num": "17/20",
      "comment": "Good job! There were a few errors in grammar and spelling.",
      "prev": "N/A",
      "docs": "N/A"
    }
  ]
};

Map<String, List<Map<String, dynamic>>> assignments2 = {
  "Math": [
    {
      "course_name": "Math",
      "mp": "3",
      "dayname": "Mon",
      "full_dayname": "Monday",
      "date": "12/20",
      "full_date": "12/20/2021",
      "teacher": "Mr. Smith",
      "category": "Homework",
      "assignment": "Page 40-41, problems 1-10",
      "description": "Complete the assigned problems in your workbook.",
      "grade_percent": "90",
      "grade_num": "9/10",
      "comment": "Great job! Just missed one question.",
      "prev": "N/A",
      "docs": "N/A"
    }
  ],
  "Science": [
    {
      "course_name": "Science",
      "mp": "3",
      "dayname": "Tus",
      "full_dayname": "Tuesday",
      "date": "12/21",
      "full_date": "12/21/2021",
      "teacher": "Ms. Johnson",
      "category": "Lab Report",
      "assignment": "Experiment 4: Chemical Reactions",
      "description":
          "Write a lab report summarizing the results of the experiment.",
      "grade_percent": "95",
      "grade_num": "19/20",
      "comment": "Excellent work! You just missed a few minor details.",
      "prev": "N/A",
      "docs": "N/A"
    },
    {
      "course_name": "Science",
      "mp": "3",
      "dayname": "Wed",
      "full_dayname": "Wednesday",
      "date": "12/24",
      "full_date": "12/24/2021",
      "teacher": "Ms. Johnson",
      "category": "Lab Report",
      "assignment": "Experiment 4: Chemical Reactions",
      "description":
          "Write a lab report summarizing the results of the experiment.",
      "grade_percent": "95",
      "grade_num": "19/20",
      "comment": "Excellent work! You just missed a few minor details.",
      "prev": "N/A",
      "docs": "N/A"
    },
    {
      "course_name": "Science",
      "mp": "3",
      "dayname": "Thus",
      "full_dayname": "Thursday",
      "date": "12/25",
      "full_date": "12/25/2021",
      "teacher": "Ms. Johnson",
      "category": "Lab Report",
      "assignment": "Experiment 4: Chemical Reactions",
      "description":
          "Write a lab report summarizing the results of the experiment.",
      "grade_percent": "95",
      "grade_num": "19/20",
      "comment": "Excellent work! You just missed a few minor details.",
      "prev": "N/A",
      "docs": "N/A"
    }
  ],
  "English": [
    {
      "course_name": "English",
      "mp": "3",
      "dayname": "Wed",
      "full_dayname": "Wednesday",
      "date": "12/22",
      "full_date": "12/22",
      "teacher": "Ms. Lee",
      "category": "Essay",
      "assignment": "Persuasive Essay",
      "description": "Write a persuasive essay on the topic given in class.",
      "grade_percent": "85",
      "grade_num": "17/20",
      "comment": "Good job! There were a few errors in grammar and spelling.",
      "prev": "N/A",
      "docs": "N/A"
    }
  ]
};
Student eddie = Student.fromJson({
  'age': 15,
  'img_url': 'https://c.tenor.com/bCfpwMjfAi0AAAAC/cat-typing.gif',
  'state_id': 4238447327,
  'birthday': '06/07/2007',
  'schedule_link': 'https://example.com',
  'name': 'Eddie Tang',
  'grade': 10,
  'locker': 'N/A',
  'counselor_name': 'Justin Charles',
  'id': 107600,
  'image64':
      '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',
  'assignments': assignments,
  'grades': grades
});

Student baddie = Student.fromJson({
  'age': 15,
  'img_url': 'https://c.tenor.com/bCfpwMjfAi0AAAAC/cat-typing.gif',
  'state_id': 4238447327,
  'birthday': '06/07/2007',
  'schedule_link': 'https://example.com',
  'name': 'Eddie Tang',
  'grade': 10,
  'locker': 'N/A',
  'counselor_name': 'James Charles',
  'id': 107600,
  'image64':
      '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAUDBAcIBwgHBwcIBwkICQcJBwkIBwkJBwkJCAcIBwYGBwkHChwXBwkaFQUFGCEYGh0dHx8fCRciJCIeJBweHx4BBQUFCAcIDwgIDRINDQ0SEhISEhISFRISEhISEhISEhISEhISEhISEhISEh4SEhIeEh4SEhIeEhISEh4SHh4SEv/AABEIALQBQAMBIgACEQEDEQH/xAAcAAAABwEBAAAAAAAAAAAAAAAAAQIDBAUGBwj/xABFEAACAQMCBAMFBgQDBQcFAAABAgMAERIEIQUTIjEyQVEGI0JhcQczUmJygRSRofCxwdFDgpKi4QgVFiRjc7Ilg8LD8f/EABoBAAMBAQEBAAAAAAAAAAAAAAACAwEEBQb/xAAmEQADAQACAgEEAQUAAAAAAAAAAQIRAyESMQQTMkFRIhQzYYHh/9oADAMBAAIRAxEAPwD0FQoUK+kR4IKFChWgChQowKACpSijVacVKRs1IZlXp/f/AFpKx1MMdLSGs88QykirFTqxVKWGnFiqb5B1BEWKo3GNbBpIH1OpkWGJBeR27D/NifQb1cCKuG/9qLibZaHQRsyizaiYDscm5cW1xl91qD+9SvlxaV4+HyrDccN+0j2fmkWNdeis3h5iuinvj1MLLfHzt6Vs4kVlyVlYd1IsQfzKfSvGycKj8XS2QU2ywuGUfi+e9x2Pka3H2d+2uv4VIqs0s+lyWOaKRs8FxxWXTtcm923B9Nr3sIf1J118RZ0elVipQipHB9dBq4E1MEiyRuqspHl+VvwmpoX+/wC/OqfU05vDOiPyqBiqVjQK1nmHiRuVQ5VSsaGNHmHiReVRGKpeFFjR5h4kQxUgxVOwoilb9QPEgmKkNHU/CkmP+/n/AH/jTLkFcFe0dN8qrBov5f50loqdcgrgrzHSkWy1KMVJdKbzE8CLahTrJSCtMmKxNChahTGAoUKFAAoUKFBqIlCjYUVURMFC1GBS1WhsBIWnFSnEjp5I6m6HUjSR08kdPJHTyJUasqoGljpxI6dVaWFqToopG1SlhaWBR2pHQ2CAteePt+jkk9oIo/EORBj1Dt7zyt3Bd9x+KvRdcI+2SO/tLB6fwsJY+XilVfLv1f3ap8naLcPVGB1elxXHl8w/Nb2H4ura/wAvO9VOonaL4W7Wa/Vf9Q7Nv+4/etxxfTMV5irk3od9qyWt08jLkqopXbE9GXT1Y7AW6a5sO3ejX/Zl9ocfDJEjbq0z/fJzL4fhdct9hmLH5D0r0RwvX6fVQrPpplmjcXV1YEfpv614+0XDLzI2XLVmUKW3QP4l5nbovyhf85rqnsNxOXhceMLYrip5TNmhO7Nie97eXmd/Wnh0iPJE0d3H9n+/OjYVzJ/b7Vp0zrFDkPd23Lfh2Un8LX9Mai6v211Yhyky7ZXDLf4lVVx8usj/AHb7WsLayHh/k6wKFq5Xwv21myWPmZSW7dww5iq3L7BgM1H7GkcW9qp/etzGzw6VVtlyj9NsiOr+f0rcZmI6wFoY1yngntZPIyrHnhkqMXa1mWyy7fI5m3fsPSroe2MiRtk2QidgxNrnFjkrfKy2v/jSOmh1x6bu1C1UHDvamGXFmXENzMT64/5dSf8AEKt9ProZV93IrHtbz/vpatVaK+NoeI/v50RW31/vJqKSaMK0jN0r4e2/5v6Nv6AntXPfbb7UdBo1aPTSJqdQ2ygN7hT+Y95AOr5bW7kXbRMbNjx3jGk0MLT6udIUX4mYC/6fxGuecT+2PSL1abSSyJa6vLaHmDbHlpJvb5/MVyT2g4pPxCbn62eXUy3YxoFIhT/2ktawC22vbf1qDFpOazczJd+8qsSOrqZjcD1/6VO+ZL0dPH8bfZ6V9hPauDi0MkkMbRvEVEiFg3iviylfLpYdh2rQNHXLv+zuGC6yPo5aiPqSMISy3Vcus7WLWrrJFPxcja0hz8amsRBaOmnSp7JTTpXSrOdyQGWkFamPHTLJVVRJyMUKWy0gin0QFChRqK00jUQWlWpxFrdESEIlPxx0uOOpEcdTqykyIjjp9EpaJTgWoOiykSq0sCjtR2qbY+AUUuiWlAUowVqO1Hajo0ArVxP7f9By+KcN1vhR42iY/mSQtjft2mXb5H0rttYj7beGLqeCyt08yB4ZITsDdZFzRT6kZ/y+VK+x4eM5ja+XxBh01m+LaO8nha/fxEAnHpVgv6Wq/wBC2KqqyZMwyW9jdfiX62WpE0bHOSSPH8Nu/kyt+Y/T+vakUazp80l2ZJtAsUfMZsY2W6t+ZcZEdfwizsb7jvex2MxeLsM44cJGzsyMtscV62UK/SCcj3BAA7+bXFuLqcYWbFVKhViUMVaNupoxMgEYGYF97edqr+Me0vL02McePSr3lkViAq+KTHdgBlYfvVepI66ZbPq9T95Ivia10ywbqPNyjkBFyGbubXtt6lLxWXHqkWNclxM2ydS+Hmb7223Bvf6E8p1HFuOcTZm0Ecs0a7cwLy0bv938hdvXv9ahrxX2g0DczW6Z5o1y5hePJgvxLzFAOPyNxXPXypTwsvjU1p2Ue0eM/JZeWzD3LDqSTvizH/ZuAsRIv5imZuL2ZmbLJ3YWN16cTGu7eohHyub+YrOcIx18KanSSMyOGLL4gPwrZrjIFUNvy+dt5UKziVVkh5bXbFQ18TtGyqPit0m9+7EdjtX6m9kvDDSLq5FkXxM2WTW2GbMGZWK74k43H7etOR8SkZmVmxVxhZr7tLeFci29ie/kAR6buaPhrSQI3Uz9WQ7Mx53U1lA83mI+QB8yKia3RNk0jLluuOPh5fRM7qb+E5OL+eND9Gp9mi4H7QRxtHDMrLGoVVPYJnJi/oVa6WIN+xPlU1tZq45maCRGSylbN1eSys24CmySja1rjfc25qnEVDMsjbdRuPEZFj6m8/KWI/K30q30HF8pMsmZWjXbcN1WyyLEBrGKAAbeIncE0izSj06PJqI9VC2mkma7C3iJiuyjFe9rdP73vYACubcW9hZtNM0mOQYt1Ndrot2Zsrd7q+3lY3q40nGLM0fMaFrMMiyM5b4mv2V727EAny7VpfZrjXM9xqepekRl1F7bMqXUAN8J227d+9FPoJXZzNIZBIy4s3XhkF3IXxdVvX5Vo9Bw+Ro3aRsVt02Yhx+rG2V+rvV/xHg7CRWXFUU36e5O+Xh2+H9h9ab49IsWibHqLLioK3OTdOPTvauHkrvDu411psvsI4XytBqdS2Xv5sFLqQxWNerxeV3/AKV0GoHsnw3+D4Zo9I3jSJTJ/wC4/vJf5F2H7VY13cKyUeXzvbYgiklacIoqsmRwYZKZeOphFNslOqEckB46ZZasHjph46tNknJExo6cZaRaqaJg0q09GlGiVJjSlqjZkKOOn1SjRKcAqDoskJApVqO1Hak0oFahR2o6wALShRIKXSgEBR0dqO1BoVqzv2jaPm8OfxXieKWwtZgrYsrfK0rn9q0lqy3t3xuOGFofEzizeYC/mHwmtXbDcOZ6D2ejimaebqVdlT17tljbpPT3qp4/rOYzQx9K9WKbqbdLL8YGN2I7W7VK41xOM4R8xoypyYBrrJ+S9z2w3t2qqGm8Un3hvZSM+UieFU7ksPEfPzsR2qnr0b79ldq+B81WXJYZWGLZXa/wtjiDkbY9xbb5VR+2vsvHBBpo5spYdTNGJ5ApWyNdnbJbZE5efm1aG8YkyaHFly5h5bSEfpXACQW7+mx37l7ScVU5QSMupjdbyRvGVR1+FlVt4yPW4sbEfKVryTRSK8Wmcj4T9pWtilWRdJpm0qhhHoxzI4lj5ZWJeZC4OQ6CT54nbfbp32We1X/iP+K02t0UUMmmSN1MTMwkifmRurLJ8a4Rb+Yf5b0XEfsu4XNI38Jq9ToCzdMckA1UKd/CVKtHGMdrk9+5ra/Zx7CtwnSamPSTxanVapo+fqHiaPGNL8qCFLnFQZZSSTufkK875fxqrjcwtf4Oz43P48idV1+TAez8MfCPaGXSKy/wepe2JU4xzM2PSLdJIVflexrt+l9mI8Y5G9Ok47qvSrMp7/B5+tYab7P7TJI0zaudnZpGKlIgzY5MyXJYAIgAuPCTe5sdbxriM+j4dli7OqLzGSMSTA+LCFY75EdRtbc+e167fjcNcfGpr2kv+nN8jlV23P7L2DhUEas2TW722UALj0qN9vdJ9AtU/GeERapcYGaFl23W6npDKrZeXT57fPavO3tv9q2rabqk1cYV7ct8omK5eNkkH5WHarvh/wBomtgjaaPWyKFjWS8kavZMcu+xta+17b1R3L6EU0uze6/2PjGTSL1rl9LPGI+7bWGHfyt/PlvGeN6nUzcrh0kWmjz5azyMA0hWyusGRGS3W9/M7/M9b9jva7/xDwvVRw4x61IJOWyry1kDK2L4N92/i27G43F9uApPxjgnEXm5baSVlmgjabTRTQtF4cIRqYyslsUO3Yjfe9cnLLrPF4dMWp7a0u9R7L+0OkXnxyvMLZ9EhYsn4u5Dbf8A9rW/Zx7XtIyx63G67ZSRklOW2JVitjGwLdrfy3p37C/aXinEuIzwa+Vtai6fmKWijQRlZEhxbkoOkiVfX7sW86f9pfZpZPaHVQcObGRYYJ5B8HM5IWf9LExOSP33rl4+RrlfF/s6aUvjXIdh4bKssP4g33fYKB4Vb1t/fnUD2d4NJxDjUWmZW/h9KVn1JG6lFbKJL2tkTtYE2FYv2K/7zib30LXU5cw5EsuIZV95te21vzE+prv/ANm+vhkilVcVkbFm6bOQvT1DvtXTcEVyYujQTm7U0RTjik11ycFCLUVqctRWrdMwRaiIpdqFqNMwZZaaeOpRFIZadUK0QXSmWWp0iUw61aaJOREa1JjWkxLUhFpKY0oIClWpQFC1S0pgm1C1KtQtWBgVqFKtQtQbgFFKtQUUusAK1HQo7UG4R9bLy42k/CGNcQ9pOLc2SWSaRcmLBWxAACsMFx2DfP611/2vdV0UuTY9PSTl3+Hdd6858Ulyn93InMZ1TlzcsKFbxdMiXm+LzO4qk9IzNYvhB/iZJGadZMjh/szYfDkikhh1eYBFX+ugVcVWN7fEy3RMmXHLBScmHV5b7DtUWeWePCKGOJRZe0byZfiVWULiRi3mfn2qm12pjGSzM00ip4crEdvFHazeLbc99vmNjIivFGWkWSCJsN1Jsxc5dLKqgmN+m5sb79u9N6jUtGvMbHTx9tpGWZjjiySLIAqjqYX3ta3fcVmq43IFaOKBZMUy5fMUrjl0b3BjJ8xuD/jW6PT6nVateZAsKWsqIrmU/lVorlfD6jfuam6KJGy4brGLI2XLDYlbzRlirWwdljQGT4wLXvbv66nS8TggwhyVpZTgqGRVZvwthI4Kg99iTv2PaqiGGDQYza1otNsosZF56rkW94NxFl09rk28u9K4vqOIyyK2gjg0wurSTT5Kwjxx7MgbA+XbdQbmqJiPs0On9oNSJnj/AISOCNFZudzAFkfLpSE92e29jt9L1E1XFOfksOpikKnGQLMHePJh0yKuysclAB2v9Kx3HpNJHq4m1c+s1rqY3XTwRv8Aw4ZuleY+xm3zuLG9wDYbVYjjDQs0cGi/hFUcxZA0YYydSojR8stkcpR28j23rPIPET7X+y0es0jQzxLIcV5Zm3e7L0ou3S98fpsNxauKjhU0url0WOWSctl8NkbOPNWY9PkR+wrqHEuJMG5080qysio3vBygcvDHHbxdN+2wve/aqT2S4ks2tnnxVXV441OO+Ksc8i3x7v5dz5VO8Y86kbL7Pfs90XCZIp21OshdltIv8SDCzY5KjIwv8XkfId7iulajQwzxtzIk1ccgvLDJGsisG8MuDXVrDa4ufrsKyHB+MKrLz2y26pRdE8RVVuxvh4xe5sTbzNaaPXTws33Ucbj/AMlJkpEjeJUkNxv0kHba972vRiXo3Wyt4Hw3hmgbUrw7TRaQzsvOOnuruFUqq4TgiFBzWOIBFydrmoOjg02i58kMLtPqXymn1MqGZvhXIsAFUdIAFhYGpPtnqFTGT7mTpeZeoxDt1KY/u9vMAj9xaqLVzMWxZlU947MjFw1m92y2LC2Ow3PnvSLjia8klr/I/lTnxb6JGm1TM3vG55yXY3VXOWKrmqWZB07C4sLeV62vsVxWSCdZPgys3pb4scR1J4t96wGh1EMje8hRmUMWtGnNQbYt0379JNrH1AN6v9OjDBuZiL5Rktj6dDKx6lGN7/Kkr+Q66O8uVbFl8LC6n5Ui1VXsfr1n0i/kC9rG6t8X88qt7U8Po57nGItQtS7ULU+i4ItQtSrULUaZgm1JIpy1C1GhhHdaYkWprLTEi1SWJSG4xTyikRingKKZkoFqFqVahap6Pgm1C1KtQtRoYJtQtSrULUaGBClUAKUBRpoQpVChWAUvtmqnQSqzMow7iwI/NXBtSIVZZJ2dipvGWjyN8cVZdgLfSu0fadO0egkbrt22vt+61wLiE0eLY5RrjkxEbEuzfEySbSNfHsNr/OrLqRV7IGqljDNJy2bdnUmRUCHHxYSWGNmW9yfkD3qk4rq+a33jXRlPRNhAGa2OPvLZXbyB71O1smm+8mjSEY4tGIMpZTicWUrszdN8e49BVYNdGjcuCBowptCrR5lC3Usqlbb3yse/9alTLJE7SaSeRfeRyqrD7xpozEfxeLeQ2yAAuflVrwKGZZk5My9G7NPJIyRjFsmjC2NgfK++PYeVRw4N4pJsnwVlKzhIEj+KWRs7Y3ZTfsTawO9p+o4lJGuMcfvHGMKFVzbp63WNReNCPNiLAA7ChAxvV61Rq/8A6dpl1epyzk1k8RVS2+XJaX7uO2XV3IJ3sLUxxLU6Jl5fEdesj55tDoZJnmA8TQSOsh6ulr2N9iLAXIquMcXjZmWSdlVehm07PHApVhnlJG953uu5UAE3sTsKj6HivDtNGv8ACabmSNiI5JIRgA1lbEKMmlP0A9Qd6V0apNUvEpFh00+ggXQQe7DNLG8docsl3b4zjfuSchcjzr9bxeNctS0kvLkSRljbZY0VlX7uMDpPKY2vbYDuQayvGePsJJZJJudI8bCOJlLrGuJVIlDEi9lCi1zvufMt6bRzapudP7tUCpEgbwlmxxb8LEsx+QYWFK7/AEMpInGuMSalmWJWWOyhpAt38Iyfy/E3z28r2qu4HqJtDqedzHmjcqJCy4ENt19JOQHUf23rpek4RFHHy8UxxUsT2vj1cvz7Ku++zij4pwWCZeXisa2k5hZQFRtsd/Ujm+vgpXL9lE0WvBOMLy8pGjaPFXkR1ZzlkeUylbmMHNACbXLW2uBWll1kcemaRubq9LPLHJMjMebp8+pJ417qQdj8m8wa47pxqeGTKvW0DPeGTEkIch0quww6VPptatx7OcXzbnxq8uqXTyYhVVIJhG2T6dRuLEIpHzvsDazKxPE3nFjzY200i8yNo8tBMLMHKr1QTCQERzA52vtY287Vj9Vq4TGnijZGtde2OXVkim0bAo3cne+5BtU3hnElE3IWVoYOI5S6Y42/hdRFIOfBl2kjvjtYbPt61C9q+F8zU5YxMF2lXEqEkXpfZT4CUv5gXPlalb0dLB+LGRmZulenFo2CA9ulnW2/8+/etpw2VZI8VzbpXE7vgy+FmXDp8S7bdu4rmcGnVMuXK0ezLgmBwO+LRtILqhP1+Xath7K6yRV5bN4RdmylAv8AC3viCwOTX2/0rNw3NOq/ZZOxZ42VlbBsg2XiVh4cvEPoSK3Vqwf2TxM2p1MjK1lReXeQMLNbI9Isw/0rfsKON+yfKu0N2oWpdqFqppLBFqFqctQtRoYN2oWpy1C1Ghg0RTTrUgim2FMmK0Ro6eApqOn1p6JyHahalWoWpBxNqFqVahagBNqFqVaitQAVqOhajtQAQFHQtR4VmgY77VJZBoJOW23ZuwBH4cmHTXn5zHlIys6uq23uqFvzSKBivV/Q+e9ekvb5L6CXpy6W/H/+vevNOugbJ8VxVsjg+arffHZiN/Ee/wCw71efsFn7ip1mom5a4q18WEj9RgCt1eOYltzj6g+Q2vUQ6JV95NHzDbHqZr4+FUk7CNercbAmwN+1WaR8r3mtnxCm8enWRkRHbLqlLOOfJ52JJFhYDYVm+JaqbVTOqx8mNepnNuhd+pgu626gDci5IsLWqDOhEh+JSNI6wquKi/NLYpCvhV1Wxxe7KAblyTsFuQIkT+GGORljbLnyMyB5Oroibl36CVvjcC2+5AJrYI4x4ZOTDGbRgsCZHxxeeY7cx+ph5gC48yTN02oj5f3K9IZlBUrEjZFWnkZbCR/D5G2PbbZNGwz/AB3UMrIrScwsrN07BBvhjjbFejYW8id7bw9Jppji3PaFV3ZVUiwy6sZGtju29t60euhj8TMq9HSoYBgqqq5M1upulLd+1KgEcS9KrI3LtyuYWEfSqq05XfYL2P4u9I0MiDwzQrjzOSqs2TRBrFvJcmGF1SytYC98f2rTJNjJFpo1Zn5bSydWAOSs0UDPuI1AViTtYA2se9fBq1j0zyyKtsrxjYu7tZuoN8vn/O5qTotc0cDLJIk8jKzXfxMW6cm/9PqlFvRO+1zqeBhapOw6V8Upk5d8t1RTkrKxvboQWO4BPyq0OrtG88bMyYRzTJkLl8jzWWNjdWIXS7jY5X2vesPx/UTFosWaEKMY8di7My8+WT5kyyg/NfnU+SeQQcz7zm4ri3SFkRfdczfqBwI22NgD52zzN8S745qtJLCsawqw5TNiLjpXxr0vbmXzuPTzN6o+Caj+GZuTlCVXmRI8h2K8uaJWy+8UWYE+l/Wp+rnjZY2m6WZZF8/dyNBGr5FvnFKPWyHzrI8VyLK2TMr9KgsDZW6l+fxX2/HUavWUUnQI+TJHyWkWFWlbUQSBmtBK69cDR/ChKkD0IXvcXn8SnjaOObmSK/LjDWYqGkTJUljOYMLEeY2um99qxfC5WimjnXqDnCTLcPHur5ZeI3RN7fFY7A1faw+GRcf4N+mNlYty5dsk92L4gMpHc2t3IIqkMWkWOgMbYNyVkLnJX6y5GzY5Sg8s3VRYkC4t8xc8OLNlGy8l7/ksY1bJcsUs3h8wDt2ql4PqeVJy5FVmU5MXVsWDL0v0qVYnLuNjcWN60KxqrKyr0sbZP3HUMVupI36Tv37+tZTGlHbPsiS8MsmXTZV8iL7+E37/ALefetsRVD9nGlWLhseOHX1ZJ2P6jc7/AN/Kr+1bxPrSXN9wm1HalWoWqmk8E2oWpdqFqNDBNqK1LtQtRoYNkU0wp8im2FMmK0QUp9KYWnkq1HPI6KO1EtKFSZVAtRWpVCjQE2orUuhRoCCKKlEUAK0MAKVRWo6AIHGoeZEy45G3SCxAJ+Fek15f9t5P4aaWONVkmzkEZxLpH1YsytYnLqsP6ivU8vvOlWxF7Mw72+JVPwnw3Ple2xNxiPtG+z3Ta6FpII0h1Cr7tsQfhxxs3y+dPFdYLnenl+d5J2WFoWjxK5SHKzBrZMrKb36thuTja42tE1fQrabRRqsSlWZ+psiviaRr2Y+DvcHbewFtHxrg+t0EzQSaZ1k94MhzUVvh5rLGTtZWsBbYkeZqniZYlbmcy/ScuXso8TteQjmHxb7eW9JSLyVTRW6lXKVTl7yRBdsupseygAb2B8NJT7zFVWQ2ykcRiTmMnwxlvO+w7mw2Hezs2sjlkkXkS+mSXCqMvw3GRADd9hY7X7R5JYx0x9JVW/2iqjZX6pAoOX0J3v53IqWji+LPJ7vx8x942DRjlhmHhjsct97/AC2JAtVLNkfct1DNSy7FANvFuAzeZvbZjfzFXUUkgjVpunPLFmYs7N8TKuxueogAWuwJvY3qdc8ZXlQK3xbY2Z3aTxduo9C7X2tY9rUtDIreJ8TaRlXzVcly8IPSvTiLMoyUdvT1tU7R8ZgjjX4irWW+wYuxVnb8TgSy79rv8haLNwu7OqsquzRhrXcKcjmim/YB3+XY1Xtw6/hZlXJsQbbCPqZvyoer+X0qbHRfarjqyY/EVxEYHwnlqvV8rra3zPypUvGJJWxXpjyV/MjLljFVLeEgov8AM+ZN6jR8JkOTNkqrjl1WJ6mbKy+pZRt5C9FOtlxj+E9R8vvCqrb16+/ypRjZyapZGx5nXy12y7HJlyv/ALijvt38iaa4rBHLgy9OOzXxBz8Kv26b+6G212vVLo92jVukqttrqSFuyopb5qov+3a9X/DNLJJk2S3UfDZ1J8S9Lbd1f129bVqnQdEGFJGVYct0Zip7MGaQKrLlba+I/wDuE+VWPAuIyRtLppI+ZC4zmXEXxX714e45g5uQPboINwxFK5WPVIq42bqC5gFfFiNwvw3FwekXHY1JiMIljm+JheNjuOu8asrWur/Ik7EXt5t6F9mq4JGzx8mfqaJfdvjnDLHjk2LNfq8LAG5sxG+wF17OwSa6VYFV1ZmXlqGHfwt0MAVPiH1uN+9Z/wBni0rKy4qyCN42bdSvi5UzbDY5i97eXmSOsfZpwiOTV85o16MT5KQfg2XfY4Da4sR6E1O2VhHWvZrQtpdJFA/UyqoYhSuR9bMSVP1JqytTWmyb3jfF4R6D/WnwKrH2nNyexNqO1KtR0+iibULUq1Has0BFqBFLtSTRoDZFIYU6wpBFMmY0Vq04ppsUta6mcaHlNLFNKacBqTKJixQtRA0dTGCtQo6FMAk0dCgKYAAUh9+lf95v/wAV+dKO/wDrSgtumsNExJb6dl+lKP8ASkamdY42ZukKK517Te3qluVpGbNfjVgVP4v1Cn4+N36Eu1Iv7VNRw7UwtBMsjSrly3jazRt8LX9P8a8y+0egkjkaNpGxveNgwW5/E292f5i1dU4jr2lkZpW6mPftv/u+dYz2u0fM6ulvEbm2/wCr/H96vy8UqcF4re9mJkmhRWXmKxXFVIkBLfC73s3k1u4HzNqgLOvMVl026FsTkxOXxtIzWFh0779r71Yal2iXp5UPiLAKbOf5k/t86p9XqZnVlyj7NllHI1/w4sxOLdPp5VwV0dy7GNdP1Nj4r43+BPzLkbqoAbawG4JA84Z1HLVVjVs2FsnUg23xlva6knPc728qVrWk5eMapdQvvMScfyYsLMxxWxue4A8qY0jSFvfsq5FVYC62HxpffJrMtxc2ue17UowuOZo2WRl/SO2+QVen1u9/3FSdBxGD7xuosjBfQd5O3p5ftUTnKOpsWNr25lySzLjjl8tx+/zqLDpo+WrN3sq4hha2y+vfxfzpcDS11fFY8VWNsUyxZtukt4m/bp/4RUeT4lijy3vl2ud1Vl/fO37eopj+CUtj5Kcbt2YsvS/5dxY/NT3p6DTctXXme76uoseh26WaykZDoO3ffzvspuj8c0nLfGNrxiygrsMlZWW0nw9K3H5vlva8L1cmXO5K26Swa+3bNlLAn9iTa1vIWb00MnLZst1CiQ9wVVfvctjey9+4vY370cMPVksmJc/d4kA928SgC1sv+lG4bhpdFrGyWNsbMOkSKCZBj9Ls3nue1u/nYR8OYe8jbZW5mGNx581Lbhv9kRb12HlVdwnTRlcerre+BYgKV+JRvi4yv2tvt8uufZN7NR6yVOeyrErKZFf4yt1xXJxiTio2APnSVyFJj8jP2fexmt4iyTRK8CR9LSPZQE3ZF8RMm/z8wdvPvHAfZ2PSLGqqtrYykfGW8LMfrt+9Xmi00cUaxxKqIosoWwAFPsK1R+xK5P0NkUKNjQAqy9EQgKUBQAo6DArUdC1HagAjSTSjRWrNAQRSDThpJFMmYVQpQohR11nAKBpammqUDStDpjwNKBplTTgNI0UTHaTRA0dIaCitRijtTAEopVCiY2WsGMN9q3H5NLAscLKrvt5E2/S1ccSZssm8TdW227fD6ft860H2n8QabiL9WSRdKhlGx/8ATN/9azS5GP8AVvfH/muv9/Ou+P4zhz55PR9J7/Fv26t/1Kp9Onzqm45N1NjiystrHb16lP8AxfSl6gsq+HJbXVtrD979/wC/OqnUy9PT1DvYKbE4nFlP4h0+l71O6KTJmOPaZT1ZL0jtiLj4vUY2/wAqzWo0jeFWa1+nq3v+UVptc3VkuVmPha4a6/la4b9qajC9Squ7C7YxnY79Nt/xH+tclLTpl4ZPU6dh/tnva2OTb/16fipjlctfCzY7qTuCzfK9/ibfvb6C22k0l+pV5m3mt3v+ZmNrX8/3qIdDJl0qt7d9hb4enL/e3+v0qfiPpkBpWLc5mZjlZbra2PixHZRvb6mmWVgyrNGrLipsLqSerJbr8XUoN7+W3atbPoJMcV7fK4BOPht6dKj96hLwyQfVst/VlYNl/wAq70uGlQGYqzR5/FkjMDmFt4RsVI7+fe/rT+i0EcmOUcvVvkGZhb4ulUO/l3/n2qedFIOrJr2UMd7IV+NRbz89rXv60uHTyK3iyHxDIrt+LpNrdLf3vWNDIVw7RyBslgWNYx1Pi7v03+BTbK2W24FWmim94q6ZWZ22u0aqP1KF8JJ/wqBpVbxdTJ28zt8WRU9reVXXD+JSRtyYYeX+crdrL/8AEeL1/wA6lSKyzZ8A4SqKrT48xvhDE4jbHIt4foPrW54NrljVZMfCbqG3/wCVfX5+tc84WZivvGZj3xFz4fCzG922yPptVhHqGLLHll5KqyX6W8TdJ/17mknj/JR3+D0R7Fe2mn1DLppMYpLWUFtmPpdRbLw7XJ3rcGvM/szqpNNJzIPcuoUdLWLDIZbrvJ8V/KvQHsrxP+K0qS5Kxt1EXG9WTOe5zstLUYoGjqhEFGKIUqsYAoUKSTWDAojR0KAEmio6I1qFKoUKAoV2nCChQoUAGDSwabowaxo3R0Glg0yDSg1I0OmOil00ppYNK0MmLFMa9lELs3bFjftt9aeBqs9qNRHHpJWkkWMYMMirMPD+UUStaRrfR504+/M1cvLykxZjbHyyOOT36R+1KiVsfwnux73/AOG+397UxrdT1Msa5KzNk72AP5vIfh2/wqJJPZWZmxK45WvGrfl9Ph9K7L9k4XRI1cd/w+v175Ldj9KzOsDfD6+8zW2+/wCE3UdPz7GrSbiDMrYyKwt38gPw9Xi+Lffv51R8QlUrkzJ8OQyGXV+od/nbyqNMrKKjWt7xsVya/lsR+lttu9Ho5ZGyZlx3UbyEqenqZjuVbxHz/wAaLVBT+K1mKjuLL0+NbBvh+VQoofi57qbqOjKxHxLfYKfpaolTSxsuP3irkOxuAfy3v/1/zjRyQhmVW5jWuxG69Vl7+nStv8BaoMEGX+0Vf1szy3/Ku+XxGpy6dRiuXhxa2O5OPS1vn0nt/jcjBCMrtjGu34t1AH5R/n8zTkWnVlbLFhf8Pmt1T/5f3aoer1WP3ePZQwxIYD8Kn4T0229Kd0sjBepWyYt9APh/o3ekNHhpFx+Fh0n6n8N+y3x+m1Im0EZ+t75BSGvv4h2/y86XzGH07b727tjft8LbGkvqLdLNup8O6nyZlv2sfpb+e5gxEbh6nqybpHiXpt3+G3SPpvc9t6Vo9NDG2TZWU9/Lp+X1xp2RGH4fDliyg3G/z6vna9tv3OFLqjdd12x3se/SpXwj/Tas8QTNFw2eyrjiuQbc+G34rtbLw+Q86s9NIp8OPV8QW1+/Vfcb22qh4bCp8Xf55Egfht3/AHrR8PjYeFkXa3VGCTjf+tjS+BRUXGhTCPLz9Tt+lcu7H+710T7IeJsk8mkfwuMo7sPEviChRa/8u1c1088nT4WHfZgx/Tgvhq89nOKcieKdo+pWXdPCO+KSYm34h5Hekcjp6ehDQqNw/VLNEkq9mF9vI/hqQac52GDQohQvSswOhQoUDAoUKFABGiNCgaBSpFChQruOEFChQoAFChQoAFKoUKxgKSnloUKVjyKFYL7ZT/5G3bI2YjYkYnaioVT439xGcv2nCpwQ6hXYX22x2G3y6u570nV6deU0nVl+o4+e9vWjoV0cpvGU3PYtj0gFiuyILAm5x26TVbrdS4CAMQsgUMoZreLuu9waFCuWjokbmiVlGSjcW2UL52+Ed9+9VThTzLqLJywigtiMiA1996OhUmMLSYjmx+JI2GKEtj7y2RIU7d/L971N5jWAO45edj2vcjH9PSKFCgBxYluiW2xU/uytcn1O1MPrZLB+m+VvDtZcQBb06mP70KFBpYQi6q3mVbt+VLioOt8X6mUH/hyyv67mjoVjAEE7rFkWMnvFW0nWoCsVBAPY2qfwlVkyYqFKk2C9ugW7N62F6OhQgLjQucWa57Ltc4ne3arCXUsnhC+W+O+zC3ahQpzUP6bUuYZGvurdx59R2PoPpTn/AHhJFGsi2YyC7B7svYCyi/SN6FClRY9C/ZWc+Fws3c+mwrVNRUKiS5PYV6OhQrGKGKOhQrDUCiNFQoBgojQoVqMP/9k=',
  'assignments': assignments,
  'grades': grades
});

Map<String, Map<String, dynamic>> grades = {
  'Math': {
    'grade': 97.98,
    'teacher_name': 'John Smith',
    'teacher_email': 'john.smith@example.com'
  },
  'English': {
    'grade': 97.7,
    'teacher_name': 'Jane Doe',
    'teacher_email': 'jane.doe@example.com'
  },
  'Science': {
    'grade': 96.6,
    'teacher_name': 'Bob Johnson',
    'teacher_email': 'bob.johnson@example.com'
  },
};

Map<String, Map<String, dynamic>> grades2 = {
  'Math': {
    'grade': 85.0,
    'teacher_name': 'John Smith',
    'teacher_email': 'john.smith@example.com'
  },
  'English': {
    'grade': 92.0,
    'teacher_name': 'Jane Doe',
    'teacher_email': 'jane.doe@example.com'
  },
  'Science': {
    'grade': 78.0,
    'teacher_name': 'Bob Johnson',
    'teacher_email': 'bob.johnson@example.com'
  },
};

ScheduleAssignmentsList scheduleAssignments = ScheduleAssignmentsList.fromJson({
  'scheduleAssignments': [
    {
      "assignment": "Day 24 HW",
      "category": "Performance Assessments",
      "course_name": "AP calculus AB",
      "date": "4/14",
      "description": "",
      "points": "50"
    },
    {
      "assignment": "Day 24 HW",
      "category": "plqy with balls",
      "course_name": "AP calculus AB",
      "date": "4/12",
      "description": "",
      "points": "50"
    },
    {
      "assignment": "Day 24 HW",
      "category": "Performance Assessments",
      "course_name": "AP calculus AB",
      "date": "4/15",
      "description": "",
      "points": "50"
    },
    {
      "assignment": "Day 24 HW",
      "category": "Performance Assessments",
      "course_name": "AP calculus AB",
      "date": "4/15",
      "description": "",
      "points": "50"
    },
    {
      "assignment": "Day 24 HW",
      "category": "Performance Assessments",
      "course_name": "AP calculus AB",
      "date": "4/15",
      "description": "",
      "points": "50"
    },
    {
      "assignment": "Day YOUR MOM HW",
      "category": "Performance Assessments",
      "course_name": "AP calculus AB",
      "date": "4/15",
      "description": "",
      "points": "50"
    },
    {
      "assignment": "Day 24 HW",
      "category": "Performance Assessments",
      "course_name": "AP calculus AB",
      "date": "4/15",
      "description": "",
      "points": "50"
    },
  ]
});

ScheduleAssignmentsList scheduleAssignments2 =
    ScheduleAssignmentsList.fromJson({
  'scheduleAssignments': [
    {
      "assignment": "Day 24 HW",
      "category": "Performance Assessments",
      "course_name": "AP calculus AB",
      "date": "4/14",
      "description": "",
      "points": "50"
    },
    {
      "assignment": "Day 24 HW",
      "category": "plqy with balls",
      "course_name": "AP calculus AB",
      "date": "4/12",
      "description": "",
      "points": "50"
    },
    {
      "assignment": "Day 24 HW",
      "category": "Performance Assessments",
      "course_name": "AP calculus AB",
      "date": "4/15",
      "description": "",
      "points": "50"
    },
    {
      "assignment": "Day 24 HW",
      "category": "Performance Assessments",
      "course_name": "AP calculus AB",
      "date": "4/15",
      "description": "",
      "points": "50"
    },
    {
      "assignment": "Day 24 HW",
      "category": "Performance Assessments",
      "course_name": "AP calculus AB",
      "date": "4/15",
      "description": "",
      "points": "50"
    },
    {
      "assignment": "Day YOUR MOM HW",
      "category": "Performance Assessments",
      "course_name": "AP calculus AB",
      "date": "4/15",
      "description": "",
      "points": "50"
    },
    {
      "assignment": "Day 24 HW",
      "category": "Performance Assessments",
      "course_name": "AP calculus AB",
      "date": "4/15",
      "description": "",
      "points": "50"
    },
  ]
});
