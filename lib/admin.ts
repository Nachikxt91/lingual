import { auth } from "@clerk/nextjs/server";


const adminIds=[
    "user_2uE0ZARMpL5j9kKciM73eUayuzZ",
];

export const isAdmin =async ()=>{
    const {userId} = await auth();

    if (!userId){
        return false;
    }

    return adminIds.indexOf(userId) !== -1;
}