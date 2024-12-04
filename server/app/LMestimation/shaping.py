import pandas as pd

# 学籍番号の列を用いて有用な行を抽出
def shaping_row(df):
    header = df.columns
    header_name = "学籍番号"
    studentID_col = None

    for col, value in enumerate(header):
        # print(f"col: {col}, Value: {value}")
        if isinstance(value, str) and not pd.isna(value) and header_name in value:
            studentID_col = col
            break
    
    if studentID_col is not None:
        df_studentID = df.iloc[:, studentID_col]
        shaped_row = df_studentID[~df_studentID.isna()].index.tolist()
        
        # print("NaN でない行:")
        # print(shaped_row)

        return shaped_row
    else:
        raise ValueError(f"ヘッダーに '{header_name}' を含む列が見つかりませんでした。")

# 型が数字の列の中から3要素と学習意欲を抽出
def shaping_col(df, shaped_row, keywords):
    first_row = df.iloc[shaped_row[0]]
    # print("first_row:", first_row)

    number_col = []
    for col, value in enumerate(first_row):
                if isinstance(value, (int, float)) and pd.notna(value):
                    number_col.append(col)
                    # print("value: ", value)

    # print("number_col:", number_col)

    keywords_col = {}

    if number_col is not None:
        header = df.columns

        for keyword in keywords:
            for col, value in enumerate(header):
                # print(f"col: {col}, Value: {value}")
                if isinstance(value, str) and not pd.isna(value) and keyword in value and col in number_col:
                    keywords_col[keyword] = [col, value]
                    break
        # print("keyword_col: ", keywords_col)

    return keywords_col

# dfの成形
def shaping_df(df, keywords):
    # 有効な行を抽出
    shaped_row = shaping_row(df)

    # キーワードの列を抽出
    shaped_col_dict = shaping_col(df, shaped_row, keywords)
    shaped_col = [value[0] for value in shaped_col_dict.values()]

    # 行、列の情報をもとにdfを作成
    shaped_df = df.iloc[shaped_row, shaped_col].dropna()

    # ヘッダーの変更
    new_header = ["学籍番号","興味","役立","期待・満足","学習意欲"]
    shaped_df.columns = new_header

    return shaped_df


#テスト用
def main():  
    input_file = "survey.csv"
    keywords =  ["学籍番号", "学習意欲","興味","期待","満足","役立"]
    df = pd.read_csv(input_file)
    shaped_row = shaping_row(df)
    shaped_col = shaping_col(df, shaped_row, keywords)
    shaped_df = df.iloc[shaped_row, list(shaped_col.values())].dropna()
    shaped_df.to_csv("test.csv", index=False, encoding="utf-8")



if __name__ == "__main__":
    main()