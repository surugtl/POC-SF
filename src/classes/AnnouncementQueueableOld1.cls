/**
 * @name AnnouncementQueueable
 * @description This class posts Chatter Announcements
**/
public class AnnouncementQueueableOld1 implements System.Queueable{

    public List<ConnectApi.AnnouncementInput> toPost;
    
    public AnnouncementQueueableOld1(List<ConnectApi.AnnouncementInput> toPost){
        this.toPost = toPost;
    }

    public void execute(QueueableContext context){
        PostAnnouncements(toPost);
    }
    
    /**
     * @name postAnnouncements
     * @description This method is provided for you to facilitate the Super Badge
    **/
    public static void PostAnnouncements(List<ConnectApi.AnnouncementInput> announcements){
        while ( announcements.size() > 0 ){
            if ( Limits.getDMLStatements() < Limits.getLimitDMLStatements() && !test.isRunningTest() ){
                ConnectApi.AnnouncementInput a = announcements.remove(0);
                ConnectApi.Announcements.postAnnouncement('Internal', a);
            } else {
                AnnouncementQueueableOld1 announcementQueuable 
                    = new AnnouncementQueueableOld1(announcements);
//              announcementQueuable.toPost = announcements;
                System.enqueueJob(announcementQueuable);
                break;
            }
        }
        if ( announcements.size() > 0 && !test.isRunningTest() ){
            AnnouncementQueueableOld1 q = 
                new AnnouncementQueueableOld1(announcements);
//            q.toPost = announcements;
            
            System.enqueueJob(q);

            //ToDo: Enqueue the above instance of announcementQueueable
        }
    }

}