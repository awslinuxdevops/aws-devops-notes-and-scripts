# Cronjob

A CronJob creates Jobs on a repeating schedule.

CronJob is meant for performing regular scheduled actions such as backups, report generation, and so on. One CronJob object is like one line of a crontab (cron table) file on a Unix system. It runs a Job periodically on a given schedule, written in Cron format


Crontabs use the following flags for adding and listing cron jobs.

**crontab -e**: edits crontab entries to add, delete, or edit cron jobs.
**crontab -l**: list all the cron jobs for the current user.
**crontab -u username -l**: list another user's crons.
**crontab -u username -e**: edit another user's crons.
When you list crons, you'll see something like this:
```
# Cron job example
* * * * * sh /path/to/script.sh
```

| **Minutes** | **Hours** | **Date of Month** | **Month** | **Date of Week** |  
| :---: | :----: | :----: | :---: | :---: |
| 0-59 | 0-23 | 1-31 | 1-12 | 0-6 | 
| * | * | * | * | * | "At every minute" |
| */10 | * | * | * | * | "At every 10th minute" |
| */30 | * | * | * | * | "At every 30th minute" |
| 0 | */2 | * | * | * | "At minute 0 past every 2nd hour." |
| 0 | */3 | * | * | * | "At minute 0 past every 3rd hour." |
| 0 | */6 | * | * | * | "At minute 0 past every 6th hour." | 
| 0 | 9-17 | * | * | * | "At minute 0 past every hour from 9 through 17." |
| 0 | 0 | * | * | * | "Every day at 12:00 Am" |
| 0 | 2 | * | * | * | "At day at 2 Am." |  
| 0 | 0 | * | * | 6,0 | "At 00:00 on Saturday and Sunday." | 
| 0 | 0 | 1 | * | 1-5 | "At 00:00 on day-of-week from Monday through Friday." |
| 0 | 0 | 1 | */6 | * | "At 00:00 on day-of-month 1 in every 6th month." |
| 0 | 0 | 1 | 1 | * | "At 00:00 on day-of-month 1 in January." |



![alt text](cronjob1.png)

![alt text](cronjob2.png)

Examples of cronjob schedule:
```
1. “At every 2nd minute from 1 through 59.”
      1-59/2 * * * *

2. “At every 15th minute.”
    */15 * * * *

3. “At every 15th minute.”
    */15 * * * *

4. “At minute 0 past every 6th hour.”
     0 */6 * * *

5. “At minute 0 past every hour from 9 through 17.”
     0 9-17 * * *

6. “At 00:00 on every day-of-week from Monday through Friday.”
     0 0 * * 1-5

7. “At 00:00 on day-of-month 1.”
     0 0 1 * *
8. “At 00:00 on Saturday and Sunday.”
     0 0 * * 6,0


```



#### Link
https://crontab.guru/examples.html


