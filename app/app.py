from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def get():
    return {'response':'OK', 'data':'On index page'}