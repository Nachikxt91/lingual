import "dotenv/config"
import type {Config} from "drizzle-kit"

export default{
    schema:"./db/schema.ts",
    dialect: "postgresql",
    out:"./drizzle",
    dbCredentials:{
        url: "postgresql://neondb_owner:npg_xXaG1I5TlfWQ@ep-silent-star-a8ium4at-pooler.eastus2.azure.neon.tech/neondb?sslmode=require",
    },
} satisfies Config;