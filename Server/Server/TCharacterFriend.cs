//------------------------------------------------------------------------------
// <auto-generated>
//     此代码已从模板生成。
//
//     手动更改此文件可能导致应用程序出现意外的行为。
//     如果重新生成代码，将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace Server
{
    using System;
    using System.Collections.Generic;
    
    public partial class TCharacterFriend
    {
        public int Id { get; set; }
        public int CharacterID { get; set; }
        public int FriendID { get; set; }
        public string FriendName { get; set; }
        public int Class { get; set; }
        public int Level { get; set; }
    
        public virtual TCharacter Owner { get; set; }
    }
}
