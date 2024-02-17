//インストールしたファイルたちを呼び出します。
import { Calendar} from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';

//<div id='calendar'></div>のidからオブジェクトを定義してカレンダーを作っていきます。
document.addEventListener('turbolinks:load', function() {
    var calendarEl = document.getElementById('calendar');

    // //カレンダーの中身を設定
    if (calendarEl) {
        var calendar = new Calendar(calendarEl, {
            plugins: [ dayGridPlugin, interactionPlugin, listPlugin ],
            initialView: 'dayGridMonth',

            //細かな表示設定
            locale: 'ja',
            timeZone: 'Asia/Tokyo',
            firstDay: 1,
            headerToolbar: {
              start: 'prev,today,next',
              center: 'title',
              end: 'dayGridMonth,listMonth'
            },
            buttonText: {
              today: '今日',
              dayGridMonth: '月間カレンダー',
              listMonth: '月間予定表'
            },
            allDayText: '終日',
            height: "auto",
            navLinks: true,
            events: '/schedules.json',

        });
        //カレンダー表示
        calendar.render();
    }
});